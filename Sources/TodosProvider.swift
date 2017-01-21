//
//  TodosProvider.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation

class TodosProvider {

    fileprivate lazy var dbTodosProvider = DbTodosProvider()

    func provideList(completion: @escaping ([Todo]?, Error?) -> Void) {
        dbTodosProvider.provideList() { json, error in
            if let error = error {
                completion(nil, error)
                return
            } else if let json = json {
                do {
                    let todos = try TodoMapper().mapToTodoList(json: json)
                    completion(todos, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}
