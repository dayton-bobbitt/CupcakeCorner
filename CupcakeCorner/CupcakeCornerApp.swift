//
//  CupcakeCornerApp.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/13/21.
//

import SwiftUI

@main
struct CupcakeCornerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    let tertiaryButtonTextColor = UIColor(named: "ColorTextButtonTertiary")!
                    
                    UINavigationBar.appearance().tintColor = tertiaryButtonTextColor
                    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = tertiaryButtonTextColor
                }
        }
    }
}
