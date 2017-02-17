//
//  GetTodosListOperation.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 22/01/2017.
//
//

import Foundation
import Kitura
import LoggerAPI

struct GetTodosListOperation: Operation {
    
    let method = HTTPMethod.GET

    let routerHandler: RouterHandler = { request, response, next in

        guard let user = request.userProfile else {
            _ = response.send(status: .unauthorized)
            next()
            return
        }

        TodosProvider().provideList(userId: user.id) { todos, error in
            if let error = error {
                response.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            } else if let todos = todos {
                response.send(json: TodoMapper().mapToJson(todoList: todos))
            }
        }
        next()
    }
}
