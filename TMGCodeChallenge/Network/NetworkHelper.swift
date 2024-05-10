//
//  NetworkHekper.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import Foundation

enum Units: String {
    case metric
    case imperial
}

struct NetworkHelper: NetworkMaker {
    private let session: URLSessionProtocol
    private let baseURL = "https://api.openweathermap.org/"
    private let keyComponent = "&APPID=40058ed9fcb02875ffb5a14019521018"

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    /// Method used to fetch the current weather for the specified location.
    /// - Parameter location: The city and country in the format "city,CO".
    /// - Returns: The `WeatherModel` object.
    func fetchWeather(for location: String?, units: Units) async throws -> WeatherModel {
        guard let location = location,
              let url = URL(string: baseURL + 
                            "data/2.5/weather?q=\(location)" +
                            keyComponent +
                            "&units=\(units.rawValue)") else {
            throw NetworkError(type: .badRequest)
        }
        let request = URLRequest(url: url)
        let (data, response) = try await session.sessionData(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError(type: .responseError)
        }

        let successCodeRange = 200...299
        if successCodeRange.contains(httpResponse.statusCode) {
            return try JSONDecoder().decode(WeatherModel.self, from: data)
        } else {
            throw NetworkError(type: .responseError, code: httpResponse.statusCode)
        }
    }
}
