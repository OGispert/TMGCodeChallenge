//
//  MockNetworkHelper.swift
//  TMGCodeChallengeTests
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

@testable import TMGCodeChallenge
import Foundation

struct MockNetworkHelper: NetworkMaker {
    var shouldThrowError = false

    func fetchWeather(for location: String?, units: Units) async throws -> WeatherModel {
        if shouldThrowError {
            throw NetworkError(type: .responseError)
        } else {
            try await mockWeatherResponse()
        }
    }

    private func mockWeatherResponse() async throws -> WeatherModel {
        do {
            let url = Bundle.main.url(forResource: "response", withExtension: "json")
            let data = try Data(contentsOf: url!)
            let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
            return weather
        } catch {
            throw NetworkError(type: .responseError)
        }
    }
}
