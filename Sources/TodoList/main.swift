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

Log.info("===== App started =====")

let bodyParser = BodyParser()

router.get("/images", middleware: StaticFileServer(path: "./images"))

// Register controllers
router.register(controller: TodosController(), middleware: credentials, bodyParser)
router.register(controller: ImagesController(), middleware: bodyParser)
router.register(controller: ReloadConfigController())

let port = Int(ProcessInfo.processInfo.environment[EnvironmentKey.PORT.rawValue] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
