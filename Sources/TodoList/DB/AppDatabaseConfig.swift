//
//  File.swift
//  backendProject
//
//  Created by Peter Bruz on 04/02/2017.
//
//

import Foundation

struct AppDatabaseConfig {
    static let host = ProcessInfo.processInfo.environment[EnvironmentKey.DB_HOST.rawValue] ?? "localhost"
    static let port = Int32(5432)
    static let name = ProcessInfo.processInfo.environment[EnvironmentKey.DB_NAME.rawValue] ?? "postgres"
    static let username = ProcessInfo.processInfo.environment[EnvironmentKey.DB_USERNAME.rawValue] ?? "postgres"
    static let password = ProcessInfo.processInfo.environment[EnvironmentKey.DB_PASSWORD.rawValue] ?? "postgres"
}
