//
//  PrimaryButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct PrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(12)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("My primary button")
            .modifier(PrimaryButton())
    }
}
