//
//  FloatingButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct FloatingButton: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    private static let cornerRadius: CGFloat = 12
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(Self.cornerRadius)
            .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 0)
    }
    
    private var foregroundColor: Color {
        Color("ColorTextButtonFloating")
    }
    
    private var backgroundColor: Color {
        Color("ColorBackgroundButtonFloating")
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Text("My floating button")
                .modifier(FloatingButton())
                .padding()
        }
        
        NavigationView {
            Text("My floating button")
                .modifier(FloatingButton())
                .padding()
        }
        .preferredColorScheme(.dark)
    }
}
