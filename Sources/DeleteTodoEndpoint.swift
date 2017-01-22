//
//  DeleteTodoEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 22/01/2017.
//
//

import Foundation
import Kitura

struct DeleteTodoEndpoint: Endpoint {
    let method = HTTPMethod.DELETE
    let path = "/todos/:id"
    let routerHandler: RouterHandler = { request, response, next in

        guard let user = request.userProfile else {
            response.send("ni ma")
            return
        }
        
        guard let id = request.parameters["id"] else {
            response.send("nie umiem przeczytać id :(")
            next()
            return
        }

        TodosRequester().delete(id: id, userId: user.id) { error in
            if let error = error {
                response.send(error.localizedDescription)
            } else {
                response.send("ok, usunięte!")
            }
            next()
        }
    }
}
