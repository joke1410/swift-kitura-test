import Foundation
import Kitura
import SwiftKuery
import SwiftKueryPostgreSQL
import HeliumLogger
import Credentials

// Create a new router
let router = Router()

HeliumLogger.use(.entry)

let postgresDatabaseUrlString = ProcessInfo.processInfo.environment["DATABASE_URL"]

let connection: PostgreSQLConnection = {
    if let postgresDatabaseUrlString = postgresDatabaseUrlString, let url = URL(string: postgresDatabaseUrlString) {
        return PostgreSQLConnection(url: url)
    } else {
        return PostgreSQLConnection(host: "localhost", port: 5432, options: [.databaseName("postgres"), .userName("postgres"), .password("postgres")])
    }
}()
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
            response.send("Error is \(error)")
            return
        }
        else {
            // Build and execute your query here.

            // First build query
            let query = Select(todos.id, todos.title, from: todos)

            connection.execute(query: query) { result in
                if let resultSet = result.asResultSet {
                    var retString = ""

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
                    response.send("Hello, \(request.parameters["username"])!, here is your data: \(retString)")
                }
                else if let queryError = result.asError {
                    // Something went wrong.
                    response.send("Something went wrong \(queryError)")
                }
            }
        }
    }

//    response.send("Hello, \(request.parameters["username"])!")
    next()
}

router.all(middleware: credentials)

router.register(controller: UsersController())

let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
