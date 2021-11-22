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
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(order.menu.cupcakes) { cupcake in
                            Image(cupcake.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: geo.size.width)
                                .clipped()
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("This week's cupcakes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct CupcakePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CupcakePickerView(order: Order())
    }
}
