//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

class Order: ObservableObject {
    let menu = Menu.load()

    @Published var cart = [CartItem]()
    
    func reset() {
        cart = []
    }
    
    func remove(cartItem: CartItem) {
        if let cartItemIndex = cart.firstIndex(where: { $0 == cartItem }) {
            cart.remove(at: cartItemIndex)
        }
    }
}
