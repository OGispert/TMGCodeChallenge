//
//  DetailsView.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: WeatherViewModel
    @State private var showErrorAlert = false

    private let baseURL = "https://openweathermap.org/"
    
    init(viewModel: WeatherViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                Text(viewModel.weather.name.unwrapped())
                    .font(.largeTitle)

                AsyncImage(url: URL(string: baseURL + "img/wn/\(viewModel.iconCode)@2x.png")) { image in
                    image
                        .frame(width: 20, height: 20)
                } placeholder: {
                    Image(systemName: "thermometer.sun")
                }
            }
            Spacer().frame(height: 80)
            
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Description: " + (viewModel.weather.weather?.first?.desc?.capitalized ?? ""))
                        .font(.title3)

                    Text("Current temperature: " + (viewModel.weather.main?.temp?.rounded() ?? ""))
                        .font(.title3)

                    Text("Feels like: " + (viewModel.weather.main?.feelsLike?.rounded() ?? ""))
                        .font(.title3)

                    Text("Min. Temp: " + (viewModel.weather.main?.tempMin?.rounded() ?? ""))
                        .font(.title3)

                    Text("Max. Temp: " + (viewModel.weather.main?.tempMax?.rounded() ?? ""))
                        .font(.title3)
                }
                .padding(.leading, 25)

                Spacer()
            }

            Spacer().frame(height: 50)

            Button("Refresh") {
                Task {
                    await viewModel.getWeather()
                    if viewModel.isError {
                        showErrorAlert = true
                    }
                }
            }
        }
        .if(viewModel.isLoading, transform: { view in
            view.blur(radius: 4.0)
        })
        .overlay {
            if viewModel.isLoading {
                VStack(spacing: 15) {
                    ProgressView()
                        .controlSize(.large)
                    Text("Loading...")
                        .font(.subheadline)
                }
            }
        }
        .alert("There was an issue. Please try again.", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        }

        Spacer()
    }
}

#Preview {
    let url = Bundle.main.url(forResource: "response", withExtension: "json")
    let data = try? Data(contentsOf: url!)
    let model = try? JSONDecoder().decode(WeatherModel.self, from: data!)
    return DetailsView(viewModel: WeatherViewModel(weather: model!))
}
