//
//  CartView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        VStack {
            List {
                ForEach($order.cart) { $cartItem in
                    CartItemRow(cartItem: $cartItem)
                }
                .onDelete(perform: order.deleteCartItem)
            }
            .listStyle(.plain)
            .navigationTitle("Your cart")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                        .tertiaryButton()
                }
            }
            
            NavigationLink(destination: ReviewView(order: order)) {
                Text("Checkout")
                    .primaryButton()
            }
            .padding()
        }
    }
    
    struct CartItemRow: View {
        @Environment(\.editMode) var editMode
        
        @Binding var cartItem: CartItem
        
        var body: some View {
            HStack(spacing: 16) {
                Text("\(cartItem.cupcake.name) x \(cartItem.quantity)")
                
                Spacer()

                if let editMode = editMode {
                    Stepper("\(cartItem.quantity) \(cartItem.cupcake.name)", value: $cartItem.quantity, in: 1...6)
                        .labelsHidden()
                        .opacity(editMode.wrappedValue.isEditing ? 1 : 0)
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let order: Order = {
            let order = Order()
            
            order.cart.append(.init(id: UUID(), cupcake: order.menu.cupcakes[0], quantity: 1))
            order.cart.append(.init(id: UUID(), cupcake: order.menu.cupcakes[1], quantity: 2))
            
            return order
        }()
        
        let orderWithDeliveryAddress: Order = {
            let order = Order()
            
            order.cart.append(.init(id: UUID(), cupcake: order.menu.cupcakes[0], quantity: 1))
            order.cart.append(.init(id: UUID(), cupcake: order.menu.cupcakes[1], quantity: 2))
            
            order.deliveryAddress = Address(fullName: "Dayton Bobbitt", streetLine1: "123 Somewhere Ln.", streetLine2: nil, city: "Nashville", state: "TN", zip: "12345")
            
            return order
        }()
        
        NavigationView {
            CartView(order: order)
        }
        
        NavigationView {
            CartView(order: orderWithDeliveryAddress)
        }
        
        Group {
            NavigationView {
                CartView(order: order)
            }
            
            NavigationView {
                CartView(order: orderWithDeliveryAddress)
            }
        }
        .preferredColorScheme(.dark)
    }
}
