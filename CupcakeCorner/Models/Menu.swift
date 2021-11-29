//
//  Menu.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

struct Menu: Codable {
    let cupcakes: [Cupcake]
    
    static func load() -> Menu {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else {
            fatalError("Failed to create URL for menu")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read data from \(url)")
        }
        
        guard let menu = try? JSONDecoder().decode(Menu.self, from: data) else {
            fatalError("Failed to decode JSON from data")
        }
        
        return menu
    }
}
