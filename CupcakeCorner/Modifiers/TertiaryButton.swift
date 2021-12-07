//
//  TertiaryButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 12/6/21.
//

import SwiftUI

struct TertiaryButton: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.medium))
            .foregroundColor(foregroundColor)
    }
    
    private var foregroundColor: Color {
        isEnabled ? Color("ColorTextButtonTertiary") : Color("ColorTextButtonTertiaryDisabled")
    }
}

struct TertiaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("My tertiary button")
            .modifier(TertiaryButton())
        
        Text("My tertiary button")
            .modifier(TertiaryButton())
            .disabled(true)
        
        Group {
            Text("My tertiary button")
                .modifier(TertiaryButton())
            
            Text("My tertiary button")
                .modifier(TertiaryButton())
                .disabled(true)
        }
        .preferredColorScheme(.dark)
            
    }
}
