//
//  CupcakePickerView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct CupcakePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var order: Order
    
    @State private var selectedCupcake: Cupcake? = nil
    
    var body: some View {
        NavigationViewWithBackground {
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(order.menu.cupcakes) { cupcake in
                            Image(cupcake.imageName)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(12)
                                .overlay(
                                    CupcakePickerCustomizationView(cupcake: cupcake, selectedCupcake: $selectedCupcake) { cartItem in
                                        order.cart.append(cartItem)
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Select cupcake")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tertiaryButton()
                    }
                }
            }
        }
    }
    
    struct CupcakePickerCustomizationView: View {
        let cupcake: Cupcake
        @Binding var selectedCupcake: Cupcake?
        let onSelect: (CartItem) -> Void
        
        @State private var quantity = 1
        private var selected: Bool {
            cupcake == selectedCupcake
        }
        
        var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Text(cupcake.name.capitalized)
                            .font(.title3)
                            .padding(.top)
                        
                        if selected {
                            Stepper("Quantity: \(quantity)", value: $quantity, in: 1...12)
                            
                            Button {
                                onSelect(.init(id: UUID(), cupcake: cupcake, quantity: quantity))
                            } label: {
                                Text("Select")
                                    .primaryButton()
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .frame(maxWidth: .infinity)
                    .background(Color("SecondaryColor"))
                }
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("SecondaryColor"), lineWidth: 5))
                .cornerRadius(12)
                .contentShape(RoundedRectangle(cornerRadius: 12))
                
                Color("SecondaryColor")
                    .opacity(0.01)
                    .onTapGesture {
                        withAnimation(.interpolatingSpring(stiffness: 250, damping: 20)) {
                            selectedCupcake = cupcake
                        }
                    }
                    .allowsHitTesting(!selected)
            }
        }
    }
}

struct CupcakePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CupcakePickerView(order: Order())
    }
}
