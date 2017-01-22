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

final class CustomCredentialsPlugin: CredentialsPluginProtocol {

    var name: String {
        return "Custom"
    }

    var usersCache: NSCache<NSString, BaseCacheElement>?

    var redirecting: Bool {
        return false
    }

    func authenticate(request: RouterRequest, response: RouterResponse, options: [String : Any], onSuccess: @escaping (UserProfile) -> Void, onFailure: @escaping (HTTPStatusCode?, [String : String]?) -> Void, onPass: @escaping (HTTPStatusCode?, [String : String]?) -> Void, inProgress: @escaping () -> Void) {

        guard let basicAuth = request.headers["Authorization"] else {
            onFailure(.forbidden, nil)
            return
        }

        identifyAndAuthenticate(basicAuth: basicAuth) { id in
            print("id")
            if let id = id {
                onSuccess(UserProfile(id: id, displayName: "p.b@c.d", provider: "custom-provider"))
            }
        }

    }

    func identifyAndAuthenticate(basicAuth: String, completion: (String?) -> Void) {
        let basicAuthComponents = basicAuth.components(separatedBy: " ")

        guard basicAuthComponents.count == 2 else {
            // completion(nil, error)
            return
        }

        let decodedData = Data(base64Encoded: basicAuthComponents[1])

        let decodedString = String(data: decodedData!, encoding: .utf8)!

        let components = decodedString.components(separatedBy: ":")

        guard components.count == 2 else {
            // completion(nil, error)
            return
        }
        print("login: \(components[0])")
        print("password: \(components[1])")
        print("hash: \(components[1].sha256)")
        completion("1")
    }
}
