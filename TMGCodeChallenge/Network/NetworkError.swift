//
//  NetworkError.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import Foundation

struct NetworkError: Error {
    enum ErrorType {
        case badRequest
        case responseError
    }

    let type: ErrorType
    let code: Int?

    init(type: ErrorType, code: Int? = nil) {
        self.type = type
        self.code = code
    }
}
