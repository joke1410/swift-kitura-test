//
//  CreateTodoEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import Kitura

struct CreateTodoEndpoint: Endpoint {
    let method = HTTPMethod.POST
    let path = "/todos"
    let routerHandler: RouterHandler = { request, response, next in

        print(request.body?.asMultiPart)

        let path = FileManager.default.currentDirectoryPath
        print(path)
        if let multipart = request.body?.asMultiPart {
            multipart.filter { $0.type == "text/plain"}.forEach {
                print("body: \($0.body)")
                if case .raw(let data) = $0.body {
                    do {
                        try data.write(to: URL(fileURLWithPath: path).appendingPathComponent("image.jpg"), options: .atomic)
                    } catch {
                        print(error)
                    }
                    print(data.description)
                    print(ProcessInfo.processInfo.environment)
                    response.send(path)
                    next()
                }
            }
        }


//        guard let user = request.userProfile else {
//            response.send("ni ma")
//            next()
//            return
//        }
//
//        guard let json = request.body?.asJSON else  {
//            response.send("a gdzie json? :(")
//            next()
//            return
//        }
//
//        guard let todo = try? TodoMapper().mapToTodo(json: json) else {
//            response.send("nie umiem tego sparsować :(")
//            next()
//            return
//        }
//
//        TodosRequester().add(todo: todo, userId: user.id) { error in
//            if let error = error {
//                response.send(error.localizedDescription)
//            } else {
//                response.send("ok!")
//            }
//            next()
//        }
    }
}
