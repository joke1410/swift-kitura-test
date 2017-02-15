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

var logger = HeliumLogger(.entry)
logger.defaultLog(.entry, msg: "Start logging")

let bodyParser = BodyParser()

router.get("/images", middleware: StaticFileServer(path: "./images"))

router.get("/refresh") { request, response, next in
    let type: LoggerMessageType =  {
        switch ProcessInfo.processInfo.environment["LOG_LEVEL"] ?? "" {
        case "ENTRY": return .entry
        case "ERROR": return .error
        default: return .verbose
        }
    }()
    logger = HeliumLogger(type)
    _ = response.send(status: .OK)
    next()
}

router.register(controller: TodosController(), middleware: credentials, bodyParser)
router.register(controller: ImagesController(), middleware: bodyParser)

let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
