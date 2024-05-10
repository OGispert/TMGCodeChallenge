//
//  String+Extensions.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

import Foundation

extension Optional where Wrapped == String {
    func unwrapped() -> String {
        guard let unwrapped = self else { return "" }
        return unwrapped
    }
}
