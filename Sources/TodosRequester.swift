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

    func add(todo: Todo, userId: String, completion: @escaping (Error?) -> Void) {
        dbTodosRequester.add(todo: todo, userId: userId, completion: completion)
    }

    func update(todo: Todo, userId: String, completion: @escaping (Error?) -> Void) {
        dbTodosRequester.update(todo: todo, userId: userId, completion: completion)
    }

    func delete(id: String, userId: String, completion: @escaping (Error?) -> Void) {
        dbTodosRequester.delete(id: id, userId: userId, completion: completion)
    }
}
