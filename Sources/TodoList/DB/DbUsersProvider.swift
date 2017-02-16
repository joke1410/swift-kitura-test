//
//  DbUsersProvider.swift
//  backendProject
//
//  Created by Peter Bruz on 04/02/2017.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import SwiftyJSON
import LoggerAPI

class DbUsersProvider {


    func provideUserId(withEmail email: String, andPasswordHash passwordHash: String, completion: @escaping (String?, Error?) -> Void) {
        let users = Users()

        let connection = ConnectionFactory.shared.createConnection()

        defer { connection.closeConnection() }
        connection.connect() { error in
            if let error = error {
                Log.error(error.localizedDescription)
                completion(nil, error)
                return
            } else {

                let query = Select(users.id, from: users).where(users.email == email && users.passwordHash == passwordHash)

                connection.execute(query: query) { result in
                    if let resultSet = result.asResultSet {
                        var id: String? = nil
                        for row in resultSet.rows {
                            id = row[0] as? String
                            break
                        }
                        completion(id, id == nil ? DbError.notFound : nil)
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
