//
//  Model.swift
//  СacheApp
//
//  Created by Yevhen Shevchenko on 16.01.2021.
//

import Foundation


struct Company: Decodable {
    let results: [Result]?
}

struct Result: Decodable {
    let name: Name?
    let email: String?
    let picture: Picture?
}

struct Name: Decodable {
    let first: String
    let last: String
    var fullName: String {
        "\(first) \(last)"
    }
}

struct Picture: Decodable {
    let medium: String?
}
