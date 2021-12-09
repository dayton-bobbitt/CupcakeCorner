//
//  View+primaryButton.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

extension View {
    func primaryButton() -> some View {
        modifier(PrimaryButton())
    }
    
    func tertiaryButton() -> some View {
        modifier(TertiaryButton())
    }
    
    func floatingButton() -> some View {
        modifier(FloatingButton())
    }
}
