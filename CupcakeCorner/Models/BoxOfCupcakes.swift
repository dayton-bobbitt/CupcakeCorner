//
//  BoxOfCupcakes.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

struct BoxOfCupcakes: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let count: Int
    let price: Double
}
