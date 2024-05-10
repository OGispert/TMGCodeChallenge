//
//  DetailsView.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    private let weather: WeatherModel
    private let iconCode: String
    private let baseURL = "https://openweathermap.org/"
    
    init(weather: WeatherModel, iconCode: String) {
        self.weather = weather
        self.iconCode = iconCode
    }
    
    var body: some View {
        HStack {
            Spacer()

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
            }
            .frame(width: 20, height: 20)
            .padding(.trailing, 40)
        }

        Spacer().frame(height: 40)

        VStack() {
            VStack(spacing: 30) {
                Text(weather.name.unwrapped())
                    .font(.largeTitle)

                AsyncImage(url: URL(string: baseURL + "img/wn/\(iconCode)@2x.png")) { image in
                    image
                        .frame(width: 20, height: 20)
                } placeholder: {
                    Image(systemName: "thermometer.sun")
                }
            }
            Spacer().frame(height: 80)
            
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Description: " + (weather.weather?.first?.desc?.capitalized ?? ""))
                        .font(.title3)

                    Text("Current temperature: " + (weather.main?.temp?.rounded() ?? ""))
                        .font(.title3)

                    Text("Feels like: " + (weather.main?.feelsLike?.rounded() ?? ""))
                        .font(.title3)

                    Text("Min. Temp: " + (weather.main?.tempMin?.rounded() ?? ""))
                        .font(.title3)

                    Text("Max. Temp: " + (weather.main?.tempMax?.rounded() ?? ""))
                        .font(.title3)
                }
                .padding(.leading, 25)

                Spacer()
            }
        }

        Spacer()
    }
}

#Preview {
    let url = Bundle.main.url(forResource: "response", withExtension: "json")
    let data = try? Data(contentsOf: url!)
    let model = try? JSONDecoder().decode(WeatherModel.self, from: data!)
    return DetailsView(weather: model!, iconCode: "02d")
}
