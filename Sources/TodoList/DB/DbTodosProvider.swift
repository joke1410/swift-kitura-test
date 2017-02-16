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
import LoggerAPI

class DbTodosProvider {

    func provideList(userId: String, completion: @escaping (JSON?, Error?) -> Void) {
        let todos = Todos()

        let connection = ConnectionFactory.shared.createConnection()

        defer { connection.closeConnection() }
        connection.connect() { error in
            if let error = error {
                Log.error(error.localizedDescription)
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
                        Log.error(queryError.localizedDescription)
                        completion(nil, queryError)
                    }
                }
            }
        }
    }
}
