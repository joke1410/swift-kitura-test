//
//  TodosRequester.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation

class TodosRequester {

    fileprivate lazy var dbTodosRequester = DbTodosRequester()

    func add(todo: Todo, completion: @escaping (Error?) -> Void) {
        dbTodosRequester.add(todo: todo, completion: completion)
    }

    func update(todo: Todo, completion: @escaping (Error?) -> Void) {
        dbTodosRequester.update(todo: todo, completion: completion)
    }

    func delete(id: String, completion: @escaping (Error?) -> Void) {
        dbTodosRequester.delete(id: id, completion: completion)
    }
}
