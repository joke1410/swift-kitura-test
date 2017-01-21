import Foundation
import Kitura
import HeliumLogger
import Credentials
import SwiftyJSON

// Create a new router
let router = Router()

HeliumLogger.use(.entry)

let credentials = Credentials()
credentials.register(plugin: CustomCredentialsPlugin())
router.all(middleware: credentials)

router.all(middleware: BodyParser())

router.register(controller: UsersController())

router.register(controller: TodosController())

let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
