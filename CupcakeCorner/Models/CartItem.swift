//
//  CartItem.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/29/21.
//

import Foundation

struct CartItem: Codable, Identifiable, Equatable {
    let id: UUID
    let cupcake: Cupcake
    let quantity: Int
}
