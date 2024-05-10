//
//  Double+Extensions.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

import Foundation

extension Double {
    func rounded() -> String {
        "\(String(format: "%.0f", self))"
    }
}
