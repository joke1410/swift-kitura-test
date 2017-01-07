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
        print("authentication")
        onSuccess(UserProfile(id: "id", displayName: "peter", provider: "simple-token"))

    }
}
