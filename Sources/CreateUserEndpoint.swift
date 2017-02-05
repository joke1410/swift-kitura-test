//
//  CreateUserEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

struct CreateUserEndpoint: Endpoint {
    let method = HTTPMethod.POST
    let path = "/users/register"
    let routerHandler: RouterHandler = { request, response, next in

        guard let json = request.body?.asJSON else  {
            response.send("a gdzie json? :(")
            next()
            return
        }

        guard let todo = try? TodoMapper().mapToTodo(json: json) else {
            response.send("nie umiem tego sparsować :(")
            next()
            return
        }

//        TodosRequester().add(todo: todo, userId: user.id) { error in
//            if let error = error {
//                response.send(error.localizedDescription)
//            } else {
//                response.send("ok!")
//            }
//            next()
//        }
        next()
    }
}
