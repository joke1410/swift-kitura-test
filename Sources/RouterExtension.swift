//
//  RouterExtension.swift
//  backendProject
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation
import Kitura

extension Router {

    func register(controller: Controller) {
        let getList = controller.endpoints.filter { $0.method == .GET }

        getList.forEach {
            get($0.path, handler: $0.routerHandler)

            all(middleware: CustomMiddleware())
        }
    }
}
