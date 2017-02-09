//
//  AddImagesEndpoint.swift
//  backendProject
//
//  Created by Peter Bruz on 08/02/2017.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct AddImagesEndpoint: Endpoint {
    let method = HTTPMethod.POST
    let path = "/images"
    let routerHandler: RouterHandler = { request, response, next in

        // WIP

        let path = FileManager.default.currentDirectoryPath
        print(path)
        if let multipart = request.body?.asMultiPart {
            multipart.filter { $0.type == "text/plain"}.forEach {
                if case .raw(let data) = $0.body {
                    do {
                        try data.write(to: URL(fileURLWithPath: path).appendingPathComponent("images/\($0.name).jpg"), options: .atomic)
                    } catch {
                        print(error)
                    }
                    _ = response.send(status: .noContent)
                    next()
                }
            }
        }
    }
}
