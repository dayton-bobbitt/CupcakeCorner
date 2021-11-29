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
    let allowedCustomizations: [String]?
    
    // TODO: Does it make sense for the menu item itself to also have pieces of the order? Probably not?
    var chosenCustomization: [String]?
}
