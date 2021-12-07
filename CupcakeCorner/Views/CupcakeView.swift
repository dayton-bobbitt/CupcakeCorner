//
//  CupcakeView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct CupcakeView: View {
    @ObservedObject var order: Order
    @Environment(\.rootPresentationMode) var rootPresentationMode
    @State private var cupcakePickerIsPresented = false
    @State private var cancelOrderAlertIsPresented = false
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(order.cart) { cartItem in
                            ZStack {
                                Image(cartItem.cupcake.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: geo.size.width / 2)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("SecondaryColor"), lineWidth: 3))
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.title2)
                                            .padding(10)
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 0.25)) {
                                                    order.remove(cartItem: cartItem)
                                                }
                                            }
                                    }
                                    
                                    Spacer()
                                }
                                
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color("SecondaryColor"))
                                        .frame(width: 80, height: 80)
                                    
                                    Image(systemName: "\(cartItem.quantity).circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                    .frame(width: 64, height: 64)
                                }
                            }
                        }
                        
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("PrimaryColor"))
                            .tileButton()
                            .frame(height: geo.size.width / 2)
                            .onTapGesture {
                                cupcakePickerIsPresented.toggle()
                            }
                    }
                    .padding()
                    .sheet(isPresented: $cupcakePickerIsPresented) {
                        CupcakePickerView(order: order)
                    }
                }
            }
            
            NavigationLink(destination: ReviewView(order: order)) {
                Text("Next")
                    .primaryButton()
            }
            .disabled(!order.isValidCart)
            .padding()
        }
        .navigationTitle("Add cupcakes")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.cancelOrderAlertIsPresented = true
                } label: {
                    Text("Cancel")
                        .tertiaryButton()
                }
            }
        }
        .alert(isPresented: $cancelOrderAlertIsPresented) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Your progress will be lost"),
                primaryButton: .default(Text("No, go back"), action: {
                    self.cancelOrderAlertIsPresented = false
                }),
                secondaryButton: .destructive(Text("Yes, cancel"), action: {
                    self.rootPresentationMode.wrappedValue.dismiss()
                })
            )
        }
    }
}

struct CupcakeView_Previews: PreviewProvider {
    static var previews: some View {
        let order: Order = {
            let order = Order()
            let cupcake = Cupcake(id: UUID(), name: "Peanut butter", imageName: "peanut-butter", price: 2.99)
            let cartItem = CartItem(id: UUID(), cupcake: cupcake, quantity: 2)
            
            order.cart.append(cartItem)
            
            return order
        }()
        
        NavigationViewWithBackground {
            CupcakeView(order: order)
        }
        
        NavigationViewWithBackground {
            CupcakeView(order: order)
        }
        .preferredColorScheme(.dark)
    }
}
