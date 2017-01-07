//
//  UsersController.swift
//  backendProject
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

final class UsersController: Controller {

    var endpoints: [Endpoint]  = [
        UserByIdEndpoint()
    ]
}
