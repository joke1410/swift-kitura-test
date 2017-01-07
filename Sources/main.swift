import Foundation
import Kitura
import SwiftKuery
import SwiftKueryPostgreSQL
import HeliumLogger
import Credentials

// Create a new router
let router = Router()

HeliumLogger.use(.entry)

let connection = PostgreSQLConnection(host: "localhost", port: 5432, options: [.databaseName("postgres"), .userName("postgres"), .password("postgres")])
print(connection)
let credentials = Credentials()
credentials.register(plugin: CustomCredentialsPlugin())

class Todos : Table {
    let tableName = "todos"
    let id = Column("id")
    let title = Column("title")
}

let todos = Todos()

// Handle HTTP GET requests to /
router.get("/:username") { request, response, next in
    print(request.parameters)

    connection.connect() { error in
        if let error = error {
            print("Error is \(error)")
            return
        }
        else {
            // Build and execute your query here.

            // First build query
            let query = Select(todos.id, todos.title, from: todos)

            connection.execute(query: query) { result in
                if let resultSet = result.asResultSet {
                    var retString = ""

                    for title in resultSet.titles {
                        // The column names of the result.
                        retString.append("\(title.padding(toLength: 35, withPad: " ", startingAt: 0)))")
                    }
                    retString.append("\n")

                    for row in resultSet.rows {
                        print("row: \(row)")
                        for value in row {
                            print("value: \(value)")
                            if let value = value as? String {
                                retString.append("\(value.padding(toLength: 35, withPad: " ", startingAt: 0))")
                            }
                        }
                        retString.append("\n")
                    }
                    print(retString)
                }
                else if let queryError = result.asError {
                    // Something went wrong.
                    print("Something went wrong \(queryError)")
                }
            }
        }
    }

    response.send("Hello, \(request.parameters["username"])!")
    next()
}

router.all(middleware: credentials)

router.register(controller: UsersController())

let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
