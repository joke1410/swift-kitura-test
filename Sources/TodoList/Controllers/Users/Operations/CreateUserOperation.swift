//
//  CreateUserOperation.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

struct CreateUserOperation: Operation {

    let method = HTTPMethod.POST

    let pathAddition = "/register"

    let routerHandler: RouterHandler = { request, response, next in

        // TODO: save user
        
        next()
    }
}
