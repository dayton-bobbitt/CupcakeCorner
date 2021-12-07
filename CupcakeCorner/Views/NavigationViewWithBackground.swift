//
//  NavigationViewWithBackground.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 12/6/21.
//

import SwiftUI

struct NavigationViewWithBackground<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ColorBackground")
                    .ignoresSafeArea()
                
                content
            }
        }
    }
}

struct NavigationViewWithBackground_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewWithBackground {
            Text("Hello, world")
        }
    }
}
