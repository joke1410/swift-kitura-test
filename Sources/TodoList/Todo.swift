//
//  Todo.swift
//  backendProject
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import SwiftyJSON

enum JSONMappingError: Error {
    case failedToMapObject(type: String)
    case failedToMapListOfObjects(type: String)
}

struct Todo {

    let id: String
    let title: String
}

struct TodoMapper {

    func mapToTodo(json: JSON) throws -> Todo {
        guard
            let id = json["id"].string,
            let title = json["title"].string
        else {
            throw JSONMappingError.failedToMapObject(type: String(describing: Todo.self))
        }

        return Todo(id: id, title: title)
    }

    func mapToTodoList(json: JSON) throws -> [Todo] {
        guard let array = json.array else {
            throw JSONMappingError.failedToMapListOfObjects(type: String(describing: Todo.self))
        }

        var todos = [Todo]()

        array.forEach { object in
            guard let todo = try? mapToTodo(json: object) else { return }
            todos.append(todo)
        }

        return todos
    }

    func mapToJson(todo: Todo) -> JSON {
        var dict: [String: Any] = [:]
        dict["id"] = todo.id
        dict["title"] = todo.title
        return JSON(dict)
    }

    func mapToJson(todoList: [Todo]) -> JSON {
        return JSON(todoList.map { mapToJson(todo: $0) })
    }
}
