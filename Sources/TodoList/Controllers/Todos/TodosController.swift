//
//  TodosController.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation

final class TodosController: Controller {

    let endpoint = "/todos"

    let operations: [Operation] = [
        CreateTodoOperation(),
        GetTodosListOperation(),
        UpdateTodoOperation(),
        DeleteTodoOperation()
    ]
}
