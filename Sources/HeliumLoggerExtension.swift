//
//  HeliumLoggerExtension.swift
//  backendProject
//
//  Created by Peter Bruz on 15/02/2017.
//
//

import HeliumLogger
import LoggerAPI

extension HeliumLogger {

    func defaultLog(_ type: LoggerMessageType, msg: String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        log(type, msg: msg, functionName: functionName, lineNum: lineNum, fileName: fileName)
    }
}
