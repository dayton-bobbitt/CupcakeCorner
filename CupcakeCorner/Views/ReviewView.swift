//
//  ReviewView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var order: Order
    
    @State private var addressViewIsPresented = false
    @State private var successViewIsActive = false
    @State private var isSubmitting = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: SuccessView(order: order), isActive: $successViewIsActive) { }
            
            if isSubmitting {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Cupcakes")
                            .font(.title2)
                        
                        Divider()
                        
                        ForEach(order.cart) { cartItem in
                            HStack {
                                Text("\(cartItem.cupcake.name) x \(cartItem.quantity)")
                                
                                Spacer()
                                
                                Text(getPrice(for: cartItem))
                            }
                            
                            Divider()
                        }
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Subtotal")
                                Spacer()
                                Text(NumberFormatter.formatCurrency(order.subtotal))
                            }
                            
                            HStack {
                                Text("Tax")
                                Spacer()
                                Text(NumberFormatter.formatCurrency(order.tax))
                            }
                            
                            HStack {
                                Text("Total")
                                Spacer()
                                Text(NumberFormatter.formatCurrency(order.total))
                            }
                            .font(.headline)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Delivery address")
                            .font(.title2)
                        
                        if let address = order.deliveryAddress {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(address.fullName)
                                    Text(address.streetLine1)
                                    
                                    if let streetLine2 = address.streetLine2, !streetLine2.isEmpty {
                                        Text(streetLine2)
                                    }
                                    
                                    Text("\(address.city), \(address.state) \(address.zip)")
                                    
                                }
                                
                                Spacer()
                                
                                Button(action: showAddressView) {
                                    Text("Edit")
                                        .tertiaryButton()
                                }
                            }
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("ColorBackgroundButtonPrimary"), lineWidth: 2))
                        } else {
                            Button(action: showAddressView) {
                                Text("Add a delivery address")
                                    .tertiaryButton()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .sheet(isPresented: $addressViewIsPresented) {
                        AddressView(order: order)
                    }
                }
                
                Button(action: submit) {
                    Text("Submit")
                        .primaryButton()
                }
                .disabled(!(order.isValidCart && order.isValidDeliveryAddress))
                .padding()
            }
        }
        .navigationTitle("Review your order")
    }
    
    private func getPrice(for cartItem: CartItem) -> String {
        NumberFormatter.formatCurrency(Double(cartItem.quantity) * cartItem.cupcake.price)
    }
    
    private func showAddressView() {
        self.addressViewIsPresented = true
    }
    
    private func submit() {
        isSubmitting = true
        
        do {
            try order.submit(onSuccess: {
                self.successViewIsActive = true
            }, onError: { _ in })
        } catch {
            print(error)
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
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
            ReviewView(order: order)
        }
        
        NavigationView {
            ReviewView(order: orderWithDeliveryAddress)
        }
        
        Group {
            NavigationView {
                ReviewView(order: order)
            }
            
            NavigationView {
                ReviewView(order: orderWithDeliveryAddress)
            }
        }
        .preferredColorScheme(.dark)
    }
}
