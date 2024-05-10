//
//  WeatherViewModel.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel
    @Published var countries: [Country]
    @Published var selectedCountry = Country(name: "United States", code: "US")
    @Published var inputText = ""
    @Published var iconCode = ""
    @Published var unitSelected = 0
    @Published private(set) var isLoading = false
    @Published private(set) var isError = false

    private let networkHelper: NetworkMaker
    private var didGetCountries = false

    init(weather: WeatherModel,
         countries: [Country] = [],
         networkHelper: NetworkMaker = NetworkHelper()) {
        self.weather = weather
        self.countries = countries
        self.networkHelper = networkHelper
    }

    @MainActor
    func getWeather() async {
        let cityCountry = inputText.appending(",\(selectedCountry.code)")
        let units: Units = unitSelected == 0 ? .imperial : .metric
        isLoading = true

        if #available(iOS 16.0, *) {
            // Not really required, but adds a nice loading animation.
            // Also notice that this is safe, as
            // it doesn't block the underlying thread,
            // according to Apple's documentation.
            do {
                try await Task.sleep(for: .seconds(2))
            } catch {
                print(error)
            }
        }

        Task {
            do {
                weather = try await networkHelper.fetchWeather(for: cityCountry, units: units)
                if let icon = weather.weather?.first?.icon {
                    iconCode = icon
                }
                isError = false
                isLoading = false
            } catch {
                isError = true
                isLoading = false
            }
        }
    }

    func getCountries() {
        if !didGetCountries {
            for code in Locale.isoRegionCodes as [String] {
                if let name = Locale.current.localizedString(forRegionCode: code) {
                    countries.append(Country(name: name, code: code))
                }
            }
            countries = countries.sorted { $0.name < $1.name }
            didGetCountries = true
        }
    }
}
