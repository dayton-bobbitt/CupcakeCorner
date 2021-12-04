//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var order = Order()
    
    var body: some View {
        NavigationView {
            HomeView(order: order)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
