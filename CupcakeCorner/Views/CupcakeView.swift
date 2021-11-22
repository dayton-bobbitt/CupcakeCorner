//
//  CupcakeView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct CupcakeView: View {
    @ObservedObject var order: Order
    @State private var showCupcakePicker = false
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        VStack {
            ScrollView {
                GeometryReader { geo in
                    LazyVGrid(columns: columns, spacing: 16) {
                        if let numberOfCupcakes = order.size?.count {
                            ForEach(0..<numberOfCupcakes) { cupcakeIndex in
                                // TODO: show image of cupcake if one is selected for index
                                Image("cupcake-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .tileButton()
                                    .frame(height: geo.size.width / 2)
                                    .onTapGesture {
                                        showCupcakePicker = true
                                    }
                                    .sheet(isPresented: $showCupcakePicker) {
                                        // TODO: pass closure to store selection
                                        CupcakePickerView(order: order)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            NavigationLink(destination: ReviewView(order: order)) {
                Text("Next")
                    .primaryButton()
            }
            .padding(.horizontal)
        }
        .navigationTitle("Select cupcakes")
    }
}

struct CupcakeView_Previews: PreviewProvider {
    static var previews: some View {
        let order: Order = {
            let order = Order()
            
            order.size = .init(id: UUID(), name: "test", count: 4, price: 99)
            
            return order
        }()
        
        CupcakeView(order: order)
    }
}
