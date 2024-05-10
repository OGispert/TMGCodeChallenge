//
//  NetworkMaker.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import Foundation

protocol NetworkMaker {
    func fetchWeather(for location: String?, units: Units) async throws -> WeatherModel
}
