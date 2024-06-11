//
//  MainButtonStyle.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 6/11/24.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.blue)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.blue.opacity(0.2))
            )
            .accessibilityAddTraits(.isButton)
    }
}
