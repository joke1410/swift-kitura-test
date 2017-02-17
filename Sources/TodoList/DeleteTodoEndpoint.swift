//
//  DeleteTodoEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 22/01/2017.
//
//

import Foundation
import Kitura
import LoggerAPI

struct DeleteTodoEndpoint: Endpoint {
    let method = HTTPMethod.DELETE
    let path = "/todos/:id"
    let routerHandler: RouterHandler = { request, response, next in

        guard let user = request.userProfile else {
            _ = response.send(status: .unauthorized)
            next()
            return
        }
        
        guard let id = request.parameters["id"] else {
            _ = response.send(status: .badRequest)
            next()
            return
        }

        TodosRequester().delete(id: id, userId: user.id) { error in
            if let error = error {
                response.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            } else {
                _ = response.send(status: .noContent)
            }
            next()
        }
    }
}
