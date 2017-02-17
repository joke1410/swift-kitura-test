//
//  ConnectionFactory.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 16/02/2017.
//
//

import Foundation
import SwiftKueryPostgreSQL

class ConnectionFactory {

    static let shared = ConnectionFactory()

    func createConnection() -> PostgreSQLConnection {
        return PostgreSQLConnection(host: AppDatabaseConfig.host, port: AppDatabaseConfig.port, options: [
            .databaseName(AppDatabaseConfig.name), .userName(AppDatabaseConfig.username), .password(AppDatabaseConfig.password)
            ]
        )
    }

    
}
