//
//  TodosController.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import Kitura

final class TodosController: Controller {

    var endpoints: [Endpoint]  = [
        CreateTodoEndpoint(),
        GetTodosListEndpoint(),
        UpdateTodoEndpoint(),
        DeleteTodoEndpoint()
    ]
}
