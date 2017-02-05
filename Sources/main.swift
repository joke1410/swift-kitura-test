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

router.register(controller: UsersController(), middleware: bodyParser)
router.register(controller: TodosController(), middleware:  bodyParser)

let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
