//
//  Address.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/30/21.
//

import Foundation

struct Address: Codable {
    let fullName: String
    let streetLine1: String
    let streetLine2: String?
    let city: String
    let state: String
    let zip: String
}
