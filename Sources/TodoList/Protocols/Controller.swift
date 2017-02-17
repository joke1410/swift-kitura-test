//
//  Controller.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 19/11/2016.
//
//

import Foundation

protocol Controller {

    var endpoint: String { get }
    var operations: [Operation] { get }
}
