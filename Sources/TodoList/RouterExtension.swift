//
//  RouterExtension.swift
//  backendProject
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

extension Router {

    func register(controller: Controller, middleware: RouterMiddleware...) {
        let getList = controller.endpoints.filter { $0.method == .GET }
        let postList = controller.endpoints.filter { $0.method == .POST }
        let putList = controller.endpoints.filter { $0.method == .PUT }
        let deleteList = controller.endpoints.filter { $0.method == .DELETE }

        getList.forEach {
            get($0.path, allowPartialMatch: false, middleware: middleware)
            get($0.path, handler: $0.routerHandler)
        }
        postList.forEach {
            post($0.path, allowPartialMatch: false, middleware: middleware)
            post($0.path, handler: $0.routerHandler)
        }
        putList.forEach {
            put($0.path, allowPartialMatch: false, middleware: middleware)
            put($0.path, handler: $0.routerHandler)
        }
        deleteList.forEach {
            delete($0.path, allowPartialMatch: false, middleware: middleware)
            delete($0.path, handler: $0.routerHandler)
        }
    }
}
