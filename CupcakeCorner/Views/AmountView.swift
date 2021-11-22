//
//  AmountView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct AmountView: View {
    @ObservedObject var order: Order
    
    @State private var tapped = false
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(order.menu.sizes) { boxOfCupcakes in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("**\(boxOfCupcakes.count)** \(getPluralizedCupcake(for: boxOfCupcakes))")
                                
                                Spacer()
                                
                                Text(NumberFormatter.formatCurrency(boxOfCupcakes.price))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .tileButton()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("PrimaryColor"), lineWidth: order.size == boxOfCupcakes ? 3 : 0)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                order.size = boxOfCupcakes
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            NavigationLink(destination: CupcakeView(order: order)) {
                Text("Next")
                    .primaryButton()
            }
            .padding(.horizontal)
        }
        .navigationTitle("How many?")
    }
    
    private func getPluralizedCupcake(for boxOfCupcakes: BoxOfCupcakes) -> String {
        boxOfCupcakes.count == 1 ? "cupcake" : "cupcakes"
    }
}

struct AmountView_Previews: PreviewProvider {
    static var previews: some View {
        AmountView(order: Order())
    }
}
