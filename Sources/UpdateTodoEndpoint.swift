//
//  UpdateTodoEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 22/01/2017.
//
//

import Foundation
import Kitura

struct UpdateTodoEndpoint: Endpoint {
    let method = HTTPMethod.PUT
    let path = "/todos"
    let routerHandler: RouterHandler = { request, response, next in

        guard let user = request.userProfile else {
            response.send("ni ma")
            next()
            return
        }

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

        TodosRequester().update(todo: todo, userId: user.id) { error in
            if let error = error {
                response.send(error.localizedDescription)
            } else {
                response.send("ok!")
            }
            next()
        }
    }
}
