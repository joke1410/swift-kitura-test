//
//  ImagesController.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 08/02/2017.
//
//

import Foundation

final class ImagesController: Controller {

    let endpoint = "/images"

    let operations: [Operation] = [
        AddImagesOperation()
    ]
}
