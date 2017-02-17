//
//  Operation.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

protocol Operation {
    var method: HTTPMethod { get }
    var pathAddition: String { get }
    var routerHandler: RouterHandler { get }
}

extension Operation {
    var pathAddition: String {
        return ""
    }
}

enum HTTPMethod {
    case GET, POST, PUT, DELETE
}
