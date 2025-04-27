//
//  Friend.swift
//  Birthdays
//
//  Created by Kiara on 4/26/25.
//

import Foundation
import SwiftData

@Model //indicates that the class is designed ot be a data model 
class Friend {
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
}
