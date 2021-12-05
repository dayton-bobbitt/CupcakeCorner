//
//  PrimaryButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct PrimaryButton: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
    }
    
    private var foregroundColor: Color {
        isEnabled ? Color.white : Color.gray
    }
    
    private var backgroundColor: Color {
        isEnabled ? Color("PrimaryColor") : Color.clear
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("My primary button")
            .modifier(PrimaryButton())
        
        Text("My primary button")
            .modifier(PrimaryButton())
            .disabled(true)
    }
}
