//
//  EnvironmentValues+RootPresentationMode.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 12/5/21.
//

import SwiftUI

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    public mutating func dismiss() {
        self.toggle()
    }
}

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    /// Allow subviews to pop to root
    ///
    /// https://github.com/Whiffer/SwiftUI-PopToRootExample
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}
