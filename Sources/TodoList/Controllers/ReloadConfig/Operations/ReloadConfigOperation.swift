//
//  ReloadConfigOperation.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 17/02/2017.
//
//

import Foundation

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

struct ReloadConfigOperation: Operation {

    let method = HTTPMethod.GET

    let routerHandler: RouterHandler = { request, response, next in

        let type: LoggerMessageType =  {
            switch ProcessInfo.processInfo.environment["LOG_LEVEL"] ?? "" {
            case "ENTRY": return .entry
            case "EXIT": return .exit
            case "DEBUG": return .debug
            case "VERBOSE": return .verbose
            case "INFO": return .info
            case "WARNING": return .warning
            case "ERROR": return .error
            default: return .verbose
            }
        }()
        HeliumLogger.use(type)
        _ = response.send(status: .OK)
        next()
    }
}
