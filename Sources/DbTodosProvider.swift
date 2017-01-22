//
//  DbTodosProvider.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import SwiftyJSON

class DbTodosProvider {

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

    func provideList(userId: String, completion: @escaping (JSON?, Error?) -> Void) {
        let todos = Todos()
        
        connection.connect() { error in
            if let error = error {
                completion(nil, error)
                return
            } else {

                let query = Select(todos.id, todos.title, from: todos).where(todos.userId == userId)

                connection.execute(query: query) { result in
                    if let resultSet = result.asResultSet {
                        var array: [[String: Any]] = []

                        for row in resultSet.rows {
                            var dict: [String: Any] = [:]
                            dict["id"] = row[0] as? String ?? ""
                            dict["title"] = row[1] as? String ?? ""
                            array.append(dict)
                        }
                        let json = JSON(array)
                        completion(json, nil)
                    }
                    else if let queryError = result.asError {
                        completion(nil, queryError)
                    }
                }
            }
        }
    }
}
