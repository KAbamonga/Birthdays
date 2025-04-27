//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Kiara on 4/26/25.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self) //responsible for loading and saving data, connects swiftData and swiftUI
        }
    }
}
