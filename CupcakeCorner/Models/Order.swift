//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

final class Order: ObservableObject, Codable {
    let menu = Menu.load()

    @Published var cart = [CartItem]()
    
    @Published var deliveryAddress: Address?
    
    init() {}
    
    private let submissionURL: URL = {
        guard let url = URL(string: "https://reqres.in/api/orders") else {
            fatalError("Failed to create submission URL")
        }
        
        return url
    }()
    
    private enum CodingKeys: CodingKey {
        case cart, deliveryAddress
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cart = try container.decode([CartItem].self, forKey: .cart)
        self.deliveryAddress = try container.decode(Address.self, forKey: .deliveryAddress)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.cart, forKey: .cart)
        try container.encode(self.deliveryAddress, forKey: .deliveryAddress)
    }
}

// MARK: - Helper functions

extension Order {
    func reset() {
        cart = []
        deliveryAddress = nil
    }
    
    func remove(cartItem: CartItem) {
        if let cartItemIndex = cart.firstIndex(where: { $0 == cartItem }) {
            cart.remove(at: cartItemIndex)
        }
    }
}

// MARK: - Calculations

extension Order {
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

// MARK: - Validations

extension Order {
    var isValidCart: Bool {
        !cart.isEmpty
    }
    
    var isValidDeliveryAddress: Bool {
        deliveryAddress?.isValid ?? false
    }
}

// MARK: - Submission

extension Order {
    func submit(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) throws {
        guard isValidCart, isValidDeliveryAddress else {
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(self) else {
            return
        }
        
        var request = URLRequest(url: submissionURL)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("accepts", forHTTPHeaderField: "application/json")
        request.httpMethod = "POST"
        
        URLSession.shared.uploadTask(with: request, from: encoded) { _data, _response, error in
            if let error = error {
                onError(error)
            } else {
                onSuccess()
            }
        }.resume()
    }
}
