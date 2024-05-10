//
//  WeatherViewModelTests.swift
//  TMGCodeChallengeTests
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

@testable import TMGCodeChallenge
import XCTest

final class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel?

    override func setUpWithError() throws {
        let url = Bundle.main.url(forResource: "response", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let model = try? JSONDecoder().decode(WeatherModel.self, from: data!)
        viewModel = WeatherViewModel(weather: model!)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetWeather() async {
        // Given
        await viewModel?.getWeather()

        // When
        let weather = viewModel?.weather

        // Then
        XCTAssertEqual(weather?.name, "Dallas")
        XCTAssertEqual(weather?.main?.temp, 81.59)
    }

    func testGetCountries() {
        // Given
        viewModel?.getCountries()

        // Then
        XCTAssertFalse(viewModel?.countries.isEmpty ?? true)
        XCTAssertEqual(viewModel?.countries.count, 257)
    }
}
