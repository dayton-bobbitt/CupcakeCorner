//
//  ReviewView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: SuccessView(order: order)) {
                Text("Submit")
                    .primaryButton()
            }
        }
        .navigationTitle("Review your order")
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(order: Order())
    }
}
