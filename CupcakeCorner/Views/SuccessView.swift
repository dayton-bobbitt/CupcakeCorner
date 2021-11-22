//
//  SuccessView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct SuccessView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        VStack {
            Text("We received your order and will get to work on those fake cupcakes right away.")
        }
        .navigationTitle("All done!")
        .navigationBarBackButtonHidden(true)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(order: Order())
    }
}
