//
//  CustomCredentialsPlugin.swift
//  backendProject
//
//  Created by Peter Bruz on 22/11/2016.
//
//

import Foundation
import Kitura
import KituraNet
import Credentials
import LoggerAPI

final class CustomCredentialsPlugin: CredentialsPluginProtocol {

    enum Error: Swift.Error {
        case wrongAuthorizationString
    }

    var name: String {
        return "Custom"
    }

    var usersCache: NSCache<NSString, BaseCacheElement>?

    var redirecting: Bool {
        return false
    }

    fileprivate lazy var usersProvider = UsersProvider()

    func authenticate(request: RouterRequest, response: RouterResponse, options: [String : Any], onSuccess: @escaping (UserProfile) -> Void, onFailure: @escaping (HTTPStatusCode?, [String : String]?) -> Void, onPass: @escaping (HTTPStatusCode?, [String : String]?) -> Void, inProgress: @escaping () -> Void) {

        guard let basicAuth = request.headers["Authorization"] else {
            onFailure(.unauthorized, nil)
            return
        }

        identifyAndAuthenticate(basicAuth: basicAuth) { id, error in
            if let error = error {
                onFailure(.unauthorized, nil)
                Log.error(error.localizedDescription)
                return
            }

            if let id = id {
                onSuccess(UserProfile(id: id, displayName: "", provider: "custom-provider"))
            }
        }

    }

    func identifyAndAuthenticate(basicAuth: String, completion: @escaping (String?, Swift.Error?) -> Void) {
        let basicAuthComponents = basicAuth.components(separatedBy: " ")

        guard basicAuthComponents.count == 2 else {
            completion(nil, Error.wrongAuthorizationString)
            return
        }

        guard let decodedData = Data(base64Encoded: basicAuthComponents[1]) else {
            completion(nil, Error.wrongAuthorizationString)
            return
        }

        let decodedString = String(data: decodedData, encoding: .utf8)!

        let components = decodedString.components(separatedBy: ":")

        guard components.count == 2 else {
             completion(nil, Error.wrongAuthorizationString)
            return
        }

        usersProvider.provideUserId(withEmail: components[0], andPasswordHash: components[1].sha256, completion: completion)
    }
}
