//
//  DbTodosRequester.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import SwiftyJSON

class DbTodosRequester {

    let dbHost = ProcessInfo.processInfo.environment["DB_HOST"] ?? "localhost"
    let dbName = ProcessInfo.processInfo.environment["DB_NAME"] ?? "postgres"
    let dbUsername = ProcessInfo.processInfo.environment["DB_USERNAME"] ?? "postgres"
    let dbPassword = ProcessInfo.processInfo.environment["DB_PASSWORD"] ?? "postgres"

    lazy var connection: PostgreSQLConnection = { [unowned self] in
        return PostgreSQLConnection(host: self.dbHost, port: 5432, options: [
            .databaseName(self.dbName), .userName(self.dbUsername), .password(self.dbPassword)
            ]
        )
    }()

    func add(todo: Todo, userId: String, completion: @escaping (Error?) -> Void) {
        let todos = Todos()

        connection.connect() { error in
            if let error = error {
                completion(error)
                return
            } else {

                let query = Insert(into: todos, valueTuples: (todos.title, todo.title), (todos.userId, userId))

                connection.execute(query: query) { result in
                    completion(result.success ? nil : result.asError)
                }
            }
        }
    }

    func update(todo: Todo, userId: String, completion: @escaping (Error?) -> Void) {
        let todos = Todos()

        connection.connect() { error in
            if let error = error {
                completion(error)
                return
            } else {

                let query = Update(todos, set: [(todos.title, todo.title)], where: todos.id == todo.id && todos.userId == userId)

                connection.execute(query: query) { result in
                    completion(result.success ? nil : result.asError)
                }
            }
        }
    }

    func delete(id: String, userId: String, completion: @escaping (Error?) -> Void) {
        let todos = Todos()

        connection.connect() { error in
            if let error = error {
                completion(error)
                return
            } else {

                let query = Delete(from: todos, where: todos.id == id && todos.userId == userId)

                connection.execute(query: query) { result in
                    completion(result.success ? nil : result.asError)
                }
            }
        }
    }
}
