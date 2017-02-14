import Foundation
import Kitura
import HeliumLogger
import Credentials
import SwiftyJSON

let router = Router()

HeliumLogger.use(.entry)

let credentials = Credentials()
credentials.register(plugin: CustomCredentialsPlugin())

let bodyParser = BodyParser()

router.get("/images", middleware: StaticFileServer(path: "./images"))

//router.register(controller: UsersController(), middleware: bodyParser)
router.register(controller: TodosController(), middleware: credentials, bodyParser)
router.register(controller: ImagesController(), middleware: bodyParser)

let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
