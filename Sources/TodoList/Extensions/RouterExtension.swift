//
//  RouterExtension.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

extension Router {

    func register(controller: Controller, middleware: RouterMiddleware...) {
        let getList = controller.operations.filter { $0.method == .GET }
        let postList = controller.operations.filter { $0.method == .POST }
        let putList = controller.operations.filter { $0.method == .PUT }
        let deleteList = controller.operations.filter { $0.method == .DELETE }

        getList.forEach {
            get(controller.endpoint + $0.pathAddition, allowPartialMatch: false, middleware: middleware)
            get(controller.endpoint + $0.pathAddition, handler: $0.routerHandler)
        }
        postList.forEach {
            post(controller.endpoint + $0.pathAddition, allowPartialMatch: false, middleware: middleware)
            post(controller.endpoint + $0.pathAddition, handler: $0.routerHandler)
        }
        putList.forEach {
            put(controller.endpoint + $0.pathAddition, allowPartialMatch: false, middleware: middleware)
            put(controller.endpoint + $0.pathAddition, handler: $0.routerHandler)
        }
        deleteList.forEach {
            delete(controller.endpoint + $0.pathAddition, allowPartialMatch: false, middleware: middleware)
            delete(controller.endpoint + $0.pathAddition, handler: $0.routerHandler)
        }
    }
}
