//
//  SelectCupcakeView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct SelectCupcakeView: View {
    @ObservedObject var order: Order
    @Environment(\.rootPresentationMode) var rootPresentationMode
    @State private var selectedCupcake: Cupcake?
    @State private var cupcakeDetailViewIsPresented = false
    @State private var cancelOrderAlertIsPresented = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 32) {
                    ForEach(order.menu.cupcakes) { cupcake in
                        VStack(spacing: 12) {
                            Image(cupcake.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: geo.size.width * 0.75)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("ColorBorderButtonSecondary"), lineWidth: 3))
                            
                            Text(cupcake.name)
                                .font(.headline)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            DispatchQueue.main.async {
                                self.selectedCupcake = cupcake
                                self.cupcakeDetailViewIsPresented = true
                            }
                        }
                    }
                }
                .padding()
                .padding(.bottom, 80)
            }
            .overlay(
                VStack {
                    Spacer()
                    if !order.cart.isEmpty {
                        NavigationLink(destination: ReviewView(order: order)) {
                            Text("Checkout")
                                .floatingButton()
                                .padding()
                        }
                    }
                }
            )
        }
        .navigationTitle("Select cupcakes")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    self.cancelOrderAlertIsPresented = true
                } label: {
                    Text("Cancel")
                        .tertiaryButton()
                }
            }
        }
        .sheet(isPresented: $cupcakeDetailViewIsPresented) {
            CupcakeDetailView(for: $selectedCupcake) { cartItem in
                self.order.cart.append(cartItem)
                self.selectedCupcake = nil
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
            
            order.cart.append(.init(id: UUID(), cupcake: order.menu.cupcakes[0], quantity: 1))
            order.cart.append(.init(id: UUID(), cupcake: order.menu.cupcakes[1], quantity: 2))
            
            return order
        }()
        
        NavigationViewWithBackground {
            SelectCupcakeView(order: order)
        }
        
        NavigationViewWithBackground {
            SelectCupcakeView(order: order)
        }
        .preferredColorScheme(.dark)
    }
}
