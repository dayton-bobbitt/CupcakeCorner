//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

class Order: ObservableObject {
    let menu = Menu.load()
    
    @Published var size: BoxOfCupcakes?
    
    func reset() {
        size = nil
    }
}
