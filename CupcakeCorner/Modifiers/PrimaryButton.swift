//
//  PrimaryButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct PrimaryButton: ViewModifier {
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
    }
    
    private var foregroundColor: Color {
        isEnabled ? Color("ColorTextButtonPrimary") : Color("ColorTextButtonPrimaryDisabled")
    }
    
    private var backgroundColor: Color {
        isEnabled ? Color("ColorBackgroundButtonPrimary") : Color("ColorBackgroundButtonPrimaryDisabled")
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Text("My primary button")
                .modifier(PrimaryButton())
                .padding()
        }
        
        NavigationView {
            Text("My primary button")
                .modifier(PrimaryButton())
                .disabled(true)
                .padding()
        }
        
        Group {
            NavigationView {
                Text("My primary button")
                    .modifier(PrimaryButton())
                    .padding()
            }
            
            NavigationView {
                Text("My primary button")
                    .modifier(PrimaryButton())
                    .disabled(true)
                    .padding()
            }
        }
        .preferredColorScheme(.dark)
    }
}
