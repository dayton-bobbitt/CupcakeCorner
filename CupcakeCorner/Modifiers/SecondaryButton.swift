//
//  SecondaryButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct SecondaryButton: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    private static let cornerRadius: CGFloat = 12
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding()
            .cornerRadius(Self.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Self.cornerRadius)
                    .stroke(borderColor, lineWidth: 1.5)
            )
    }
    
    private var foregroundColor: Color {
        isEnabled ? Color("ColorTextButtonSecondary") : Color("ColorTextButtonSecondaryDisabled")
    }
    
    private var borderColor: Color {
        isEnabled ? Color("ColorBorderButtonSecondary") : Color("ColorBorderButtonSecondaryDisabled")
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewWithBackground {
            Text("My secondary button")
                .modifier(SecondaryButton())
                .padding()
        }
        
        NavigationViewWithBackground {
            Text("My secondary button")
                .modifier(SecondaryButton())
                .disabled(true)
                .padding()
        }
        
        Group {
            NavigationViewWithBackground {
                Text("My secondary button")
                    .modifier(SecondaryButton())
                    .padding()
            }
            
            NavigationViewWithBackground {
                Text("My secondary button")
                    .modifier(SecondaryButton())
                    .disabled(true)
                    .padding()
            }
        }
        .preferredColorScheme(.dark)
    }
}
