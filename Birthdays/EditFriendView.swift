//
//  EditFriendView.swift
//  Birthdays
//
//  Created by Kiara on 4/27/25.
//

import SwiftUI

struct EditFriendView: View {
    var friend: Friend // new property to hold the Friend that was selected
    @State private var newName: String
    @State private var newBirthday: Date
    @Environment(\.dismiss) private var dismiss //dismisses the sheet
    
    init(friend: Friend) {
        self.friend = friend
        _newName = State(initialValue: friend.name)
        _newBirthday = State(initialValue: friend.birthday)
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $newName)
            DatePicker("Birthday", selection: $newBirthday, displayedComponents: .date)
        }
        .navigationTitle("Edit Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { //cancellationAction lets SwiftUI choose the best location for it
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            // allows them to cancel edits without modifying the original data
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    friend.name = newName
                    friend.birthday = newBirthday
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack { // how u view the nav bar
        EditFriendView(friend: Friend(name: "Test", birthday: Date.now))
    }
}
