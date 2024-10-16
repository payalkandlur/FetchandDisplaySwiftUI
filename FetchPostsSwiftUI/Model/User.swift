//
//  User.swift
//  FetchPostsSwiftUI
//
//  Created by Payal Kandlur on 10/16/24.
//

import Foundation
struct Users: Codable {
    let users: [User]
}

struct User: Codable, Identifiable {
    let firstName: String
    let id: Int
    let email: String
}

