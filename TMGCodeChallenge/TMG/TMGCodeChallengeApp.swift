//
//  TMGCodeChallengeApp.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import SwiftUI

@main
struct TMGCodeChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            let url = Bundle.main.url(forResource: "response", withExtension: "json")
            let data = try? Data(contentsOf: url!)
            let model = try? JSONDecoder().decode(WeatherModel.self, from: data!)
            WeatherView(viewModel: WeatherViewModel(weather: model!))
        }
    }
}
