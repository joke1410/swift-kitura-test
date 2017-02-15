//
//  UpdateTodoEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 22/01/2017.
//
//

import Foundation
import Kitura
import LoggerAPI

struct UpdateTodoEndpoint: Endpoint {
    let method = HTTPMethod.PUT
    let path = "/todos"
    let routerHandler: RouterHandler = { request, response, next in

        logger.defaultLog(.debug, msg: "zaczynamy zabawę")
        guard let user = request.userProfile else {
            logger.defaultLog(.debug, msg: "nie ma takiego usera")
            _ = response.send(status: .unauthorized)
            next()
            return
        }

        guard let json = request.body?.asJSON else  {
            Log.debug("nie ma body lub to nie json")
            _ = response.send(status: .unprocessableEntity)
            next()
            return
        }

        guard let todo = try? TodoMapper().mapToTodo(json: json) else {
            logger.defaultLog(.debug, msg: "oups, jesteś pewien że dobrze stworzyłeś JSON'a?")
            _ = response.send(status: .unprocessableEntity)
            next()
            return
        }

        TodosRequester().update(todo: todo, userId: user.id) { error in
            if let error = error {
                response.send(error.localizedDescription)
            } else {
                logger.defaultLog(.debug, msg: "no to odpowiadamy...")
                _ = response.send(status: .noContent)
                response.status(.noContent).send("")
                logger.defaultLog(.debug, msg: "...odpowiedzieliśmy")
            }
            next()
        }
    }
}
