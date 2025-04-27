//
//  ContentView.swift
//  Birthdays
//
//  Created by Kiara on 4/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend] //query allows us to fetch Friend instances stored in SwiftData
    @Environment(\.modelContext) private var context //connection between the view and the model container so we can fetch, insert, and delete items in teh container similar to data caching
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend? //keeps track of selected friend, question mark means it's an optional type so it can hold an instance of Friend or it might hold nil
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    HStack {
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
                    .onTapGesture {
                        selectedFriend = friend
                    }
                }
                .onDelete(perform: deleteFriend)
            }
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                NavigationStack {
                    EditFriendView(friend: friend)
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend) //inserts the new Friend model into the ModelContext
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    }
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true) // ensures interactive prview also uses SwiftData for data management
    
}
