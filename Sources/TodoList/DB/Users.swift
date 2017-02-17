//
//  Users.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 04/02/2017.
//

import Foundation
import SwiftKuery

class Users : Table {
    let tableName = "users"
    let id = Column("id")
    let email = Column("email")
    let passwordHash = Column("password_hash")
}
