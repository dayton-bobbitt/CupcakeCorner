//
//  HomeView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Cupcake\nCorner")
                .font(.largeTitle)
                .foregroundColor(Color("PrimaryColor"))
            
            Spacer()
            
            NavigationLink(destination: AmountView(order: order)) {
                Text("Place an order")
                    .primaryButton()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .onAppear {
            // Reset order whenever the HomeView appears
            order.reset()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(order: Order())
    }
}
