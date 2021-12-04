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
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Cupcakes")
                        .font(.title2)
                    
                    Divider()
                    
                    ForEach(order.cart) { cartItem in
                        HStack {
                            Text(cartItem.cupcake.name)
                            
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
                .padding(.horizontal)
                
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
                            }
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("SecondaryColor"), lineWidth: 2))
                    } else {
                        Button(action: showAddressView) {
                            Text("Add a delivery address")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])
                .sheet(isPresented: $addressViewIsPresented) {
                    AddressView(order: order)
                }
            }
            
            NavigationLink(destination: SuccessView(order: order)) {
                Text("Submit")
                    .primaryButton()
            }
            .padding()
        }
        .navigationTitle("Review your order")
    }
    
    private func getPrice(for cartItem: CartItem) -> String {
        let price = NumberFormatter.formatCurrency(cartItem.cupcake.price)
        
        if cartItem.quantity == 1 {
            return price
        } else {
            return "\(cartItem.quantity) x \(price)"
        }
    }
    
    private func showAddressView() {
        self.addressViewIsPresented = true
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let order: Order = {
            let order = Order()
            let cupcake1 = Cupcake(id: UUID(), name: "Peanut butter", imageName: "peanut-butter", price: 2.99)
            let cartItem1 = CartItem(cupcake: cupcake1, quantity: 1)
            
            let cupcake2 = Cupcake(id: UUID(), name: "Chocolate ganache", imageName: "chocolate-ganache", price: 2.99)
            let cartItem2 = CartItem(cupcake: cupcake2, quantity: 2)
            
            order.cart.append(cartItem1)
            order.cart.append(cartItem2)
            
            return order
        }()
        
        let orderWithDeliveryAddress: Order = {
            let order = Order()
            let cupcake1 = Cupcake(id: UUID(), name: "Peanut butter", imageName: "peanut-butter", price: 2.99)
            let cartItem1 = CartItem(cupcake: cupcake1, quantity: 1)
            
            let cupcake2 = Cupcake(id: UUID(), name: "Chocolate ganache", imageName: "chocolate-ganache", price: 2.99)
            let cartItem2 = CartItem(cupcake: cupcake2, quantity: 2)
            
            order.cart.append(cartItem1)
            order.cart.append(cartItem2)
            
            order.deliveryAddress = Address(fullName: "Dayton Bobbitt", streetLine1: "123 Somewhere Ln.", streetLine2: nil, city: "Nashville", state: "TN", zip: "12345")
            
            return order
        }()
        
        ReviewView(order: order)
        ReviewView(order: orderWithDeliveryAddress)
    }
}
