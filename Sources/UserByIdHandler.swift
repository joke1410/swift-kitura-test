//
//  UserByIdHandler.swift
//  backendProject
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

struct UserByIdEndpoint: Endpoint {
    let method = HTTPMethod.GET
    let path = "/users/:id"
    let routerHandler: RouterHandler = { request, response, next in
        if let value = request.parameters["id"], let id = Int(value) {
            response.send("You want to get data for id=\(id)")
        } else {
            response.send(status: .badRequest)
        }

        next()
    }
}
