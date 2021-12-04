//
//  Cupcake.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

struct Cupcake: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let imageName: String
    let price: Double
}
