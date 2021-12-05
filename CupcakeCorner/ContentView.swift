//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var order = Order()
    
    @State private var isOrdering = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Cupcake\nCorner")
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryColor"))
                
                Spacer()
                
                NavigationLink(destination: CupcakeView(order: order).environment(\.rootPresentationMode, $isOrdering), isActive: $isOrdering) { }
                
                Button {
                    isOrdering = true
                } label: {
                    Text("Place an order")
                        .primaryButton()
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .onAppear {
                // Reset order whenever the this view appears
                order.reset()
            }
        }
        .navigationViewStyle(.stack)
        .environment(\.rootPresentationMode, $isOrdering)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
