//
//  SuccessView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct SuccessView: View {
    @ObservedObject var order: Order
    
    @Environment(\.rootPresentationMode) var rootPresentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("We received your order and will get to work on those fake cupcakes right away.")
            
            Spacer()
            
            Button {
                rootPresentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")
                    .primaryButton()
            }
            .padding()

        }
        .navigationTitle("All done!")
        .navigationBarBackButtonHidden(true)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {        
            SuccessView(order: Order())
        }
    }
}
