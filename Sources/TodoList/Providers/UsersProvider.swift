//
//  UsersProvider.swift
//  backendProject
//
//  Created by Peter Bruz on 04/02/2017.
//
//

import Foundation

class UsersProvider {

    fileprivate lazy var dbUsersProvider = DbUsersProvider()

    func provideUserId(withEmail email: String, andPasswordHash passwordHash: String, completion: @escaping (String?, Error?) -> Void) {
        dbUsersProvider.provideUserId(withEmail: email, andPasswordHash: passwordHash, completion: completion)
    }
}
