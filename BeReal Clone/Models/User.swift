//
//  User.swift
//  BeReal Clone
//
//  Created by Victoria Nunez on 4/5/23.
//

import ParseSwift
import Foundation


struct User: ParseUser {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?

} 
