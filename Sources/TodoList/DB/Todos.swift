//
//  Todos.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//

import Foundation
import SwiftKuery

class Todos : Table {
    let tableName = "todos"
    let id = Column("id")
    let title = Column("title")
    let userId = Column("user_id")
}
