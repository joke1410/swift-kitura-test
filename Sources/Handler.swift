//
//  Handler.swift
//  backendProject
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var routerHandler: RouterHandler { get }
}

enum HTTPMethod {
    case GET, POST, PUT, DELETE
}
