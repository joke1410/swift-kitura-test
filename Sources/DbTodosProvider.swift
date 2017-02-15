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

    fileprivate lazy var connection: PostgreSQLConnection = { [unowned self] in
        return PostgreSQLConnection(host: AppDatabaseConfig.host, port: AppDatabaseConfig.port, options: [
            .databaseName(AppDatabaseConfig.name), .userName(AppDatabaseConfig.username), .password(AppDatabaseConfig.password)
            ]
        )
    }()

    func provideList(userId: String, completion: @escaping (JSON?, Error?) -> Void) {
        let todos = Todos()
        
        connection.connect() { error in
            if let error = error {
                logger.defaultLog(.error, msg: error.localizedDescription)
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
                        logger.defaultLog(.error, msg: queryError.localizedDescription)
                        completion(nil, queryError)
                    }
                }
            }
        }
    }
}
