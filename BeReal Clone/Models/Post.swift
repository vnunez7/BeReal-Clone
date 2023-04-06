//
//  Post.swift
//  BeReal Clone
//
//  Created by Victoria Nunez on 4/5/23.
//

import Foundation
import ParseSwift


struct Post: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var caption: String?
    var user: User?
    var imageFile: ParseFile?
}

