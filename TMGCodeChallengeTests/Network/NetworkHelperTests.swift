//
//  NetworkHelperTests.swift
//  TMGCodeChallengeTests
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

@testable import TMGCodeChallenge
import XCTest

final class NetworkHelperTests: XCTestCase {
    
    var network: NetworkHelper?

    override func setUpWithError() throws {
        network = NetworkHelper()
    }

    override func tearDownWithError() throws {
        network = nil
    }

    func testFetchWeatherSuccess() async throws {
        // Given
        network = NetworkHelper(session: MockURLSession(mockFile: "response"))

        // When
        let weather = try await network?.fetchWeather(for: "Dallas,US", units: .imperial)

        // Then
        XCTAssertEqual(weather?.name, "Dallas")
        XCTAssertEqual(weather?.main?.temp, 81.59)
    }

    func testFetchWeatherError() async throws {
        // Given
        network = NetworkHelper(session: MockURLSession(mockFile: "response",
                                                        isResponseError: true))

        // When
        do {
            _ = try await network?.fetchWeather(for: "Dallas,US", units: .imperial)
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual((error as? NetworkError)?.type, .responseError)
        }
    }
}
