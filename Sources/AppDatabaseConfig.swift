//
//  File.swift
//  backendProject
//
//  Created by Peter Bruz on 04/02/2017.
//
//

import Foundation

struct AppDatabaseConfig {
    static let host = ProcessInfo.processInfo.environment["DB_HOST"] ?? "localhost"
    static let port = Int32(5432)
    static let name = ProcessInfo.processInfo.environment["DB_NAME"] ?? "postgres"
    static let username = ProcessInfo.processInfo.environment["DB_USERNAME"] ?? "postgres"
    static let password = ProcessInfo.processInfo.environment["DB_PASSWORD"] ?? "postgres"
}
