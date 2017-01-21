//
//  CreateTodoEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import Kitura

struct CreateTodoEndpoint: Endpoint {
    let method = HTTPMethod.POST
    let path = "/todos"
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

        TodosRequester().add(todo: todo) { error in
            if let error = error {
                response.send(error.localizedDescription)
            } else {
                response.send("ok!")
            }
            next()
        }
    }
}
