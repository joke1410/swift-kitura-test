//
//  UsersController.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation

final class UsersController: Controller {

    let endpoint = "/users"

    let operations: [Operation] = [
        CreateUserOperation()
    ]
}
