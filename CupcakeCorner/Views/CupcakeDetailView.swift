//
//  CupcakeDetailView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 12/7/21.
//

import SwiftUI

struct AsymmetricRoundedRectangle: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(_ radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(bezierPath.cgPath)
    }
}

struct CupcakeDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding private var cupcake: Cupcake?
    private let onAddToCart: (CartItem) -> Void
    @State private var quantity = 1
    
    init(for cupcake: Binding<Cupcake?>, onAddToCart: @escaping (CartItem) -> Void) {
        self._cupcake = cupcake
        self.onAddToCart = onAddToCart
    }
    
    var body: some View {
        if let cupcake = cupcake {
            NavigationView {
                GeometryReader { geo in
                    ScrollView {
                        VStack(spacing: 32) {
                            Image(cupcake.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: geo.size.width)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text(cupcake.description)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Stepper("Quantity: \(self.quantity)", value: $quantity, in: 1...6)
                            
                            Button(action: addToCart) {
                                Text("Add to cart")
                                    .primaryButton()
                            }
                        }
                    }
                    .padding()
                    .navigationTitle(cupcake.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Close")
                                    .tertiaryButton()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    private func addToCart() {
        guard let cupcake = cupcake else {
            fatalError("Attempted to add to cart but cupcake was nil")
        }

        let cartItem = CartItem(id: UUID(), cupcake: cupcake, quantity: quantity)
        
        onAddToCart(cartItem)
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct CupcakeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let menu = Menu.load()
        
        CupcakeDetailView(for: .constant(menu.cupcakes[0])) { _ in }
        
        CupcakeDetailView(for: .constant(menu.cupcakes[0])) { _ in }
        .preferredColorScheme(.dark)
    }
}
