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
            _ = response.send(status: .unauthorized)
            next()
            return
        }

        guard let json = request.body?.asJSON else  {
            _ = response.send(status: .unprocessableEntity)
            next()
            return
        }

        guard let todo = try? TodoMapper().mapToTodo(json: json) else {
            _ = response.send(status: .unprocessableEntity)
            next()
            return
        }

        TodosRequester().update(todo: todo, userId: user.id) { error in
            if let error = error {
                response.send(error.localizedDescription)
            } else {
                _ = response.send(status: .noContent)
            }
            next()
        }
    }
}
