//
//  GetTodosListEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 22/01/2017.
//
//

import Foundation
import Kitura

struct GetTodosListEndpoint: Endpoint {
    let method = HTTPMethod.GET
    let path = "/todos"
    let routerHandler: RouterHandler = { request, response, next in

        guard let user = request.userProfile else {
            _ = response.send(status: .unauthorized)
            next()
            return
        }

        TodosProvider().provideList(userId: user.id) { todos, error in
            if let error = error {
                response.send(error.localizedDescription)
            } else if let todos = todos {
                response.send(json: TodoMapper().mapToJson(todoList: todos))
            }
        }
        next()
    }
}
