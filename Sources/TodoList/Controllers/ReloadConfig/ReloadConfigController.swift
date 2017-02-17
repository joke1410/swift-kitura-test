//
//  ReloadConfigController.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 17/02/2017.
//
//

import Foundation

final class ReloadConfigController: Controller {

    let endpoint = "/reload"

    let operations: [Operation] = [
        ReloadConfigOperation()
    ]
}
