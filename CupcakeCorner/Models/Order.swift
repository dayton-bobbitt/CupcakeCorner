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
    
    @Published var deliveryAddress: Address?
    
    func reset() {
        cart = []
    }
    
    func remove(cartItem: CartItem) {
        if let cartItemIndex = cart.firstIndex(where: { $0 == cartItem }) {
            cart.remove(at: cartItemIndex)
        }
    }
    
    var subtotal: Double {
        cart.reduce(0.0) { partialResult, cartItem in
            partialResult + Double(cartItem.quantity) * cartItem.cupcake.price
        }
    }
    
    var tax: Double {
        subtotal * 0.07
    }
    
    var total: Double {
        subtotal + tax
    }
}
