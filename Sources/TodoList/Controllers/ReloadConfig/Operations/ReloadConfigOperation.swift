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
            switch ProcessInfo.processInfo.environment[EnvironmentKey.LOG_LEVEL.rawValue] ?? "" {
            case LoggerMessageType.entry.description: return .entry
            case LoggerMessageType.exit.description: return .exit
            case LoggerMessageType.debug.description: return .debug
            case LoggerMessageType.verbose.description: return .verbose
            case LoggerMessageType.info.description: return .info
            case LoggerMessageType.warning.description: return .warning
            case LoggerMessageType.error.description: return .error
            default: return .verbose
            }
        }()
        HeliumLogger.use(type)
        _ = response.send(status: .OK)
        next()
    }
}
