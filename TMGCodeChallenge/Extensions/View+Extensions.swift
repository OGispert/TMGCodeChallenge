//
//  View+Extensions.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    /// Source: https://www.avanderlee.com/swiftui/conditional-view-modifier/
    @ViewBuilder
    func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }

    func mainButtonStyle() -> some View {
        modifier(ButtonStyle())
    }
}
