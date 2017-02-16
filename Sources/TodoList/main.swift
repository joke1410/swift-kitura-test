import Foundation
import Kitura
import HeliumLogger
import LoggerAPI
import Credentials
import SwiftyJSON

let router = Router()

HeliumLogger.use(.entry)

let credentials = Credentials()
credentials.register(plugin: CustomCredentialsPlugin())

Log.info("App started")

let bodyParser = BodyParser()

router.get("/images", middleware: StaticFileServer(path: "./images"))

router.get("/refresh") { request, response, next in
    let type: LoggerMessageType =  {
        switch ProcessInfo.processInfo.environment["LOG_LEVEL"] ?? "" {
        case "ENTRY": return .entry
        case "EXIT": return .exit
        case "DEBUG": return .debug
        case "VERBOSE": return .verbose
        case "INFO": return .info
        case "WARNING": return .warning
        case "ERROR": return .error
        default: return .verbose
        }
    }()
    HeliumLogger.use(type)
    _ = response.send(status: .OK)
    next()
}

router.register(controller: TodosController(), middleware: credentials, bodyParser)
router.register(controller: ImagesController(), middleware: bodyParser)

let port = Int(ProcessInfo.processInfo.environment[EnvironmentKey.PORT.rawValue] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
