//
//  MockURLSession.swift
//  TMGCodeChallengeTests
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

@testable import TMGCodeChallenge
import Foundation

class MockURLSession: URLSessionProtocol {
    private let mockFile: String
    private let isResponseError: Bool

    init(mockFile: String = "", isResponseError: Bool = false) {
        self.mockFile = mockFile
        self.isResponseError = isResponseError
    }

    func sessionData(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let requestURL = request.url else {
            throw NetworkError(type: .badRequest)
        }
        let mockResponse = HTTPURLResponse(url: requestURL, statusCode: isResponseError ? 404 : 200, httpVersion: nil, headerFields: nil)!
        let url = Bundle.main.url(forResource: mockFile, withExtension: "json")
        let mockData = try Data(contentsOf: url!)
        if isResponseError {
            throw NetworkError(type: .responseError, code: 404)
        } else {
            return (mockData, mockResponse)}
    }
}
