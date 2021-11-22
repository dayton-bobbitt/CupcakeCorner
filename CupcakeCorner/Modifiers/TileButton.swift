//
//  TileButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct TileButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.black)
            .background(Color("SecondaryColor"))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

struct TileButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("My tile button")
            .modifier(TileButton())
    }
}
