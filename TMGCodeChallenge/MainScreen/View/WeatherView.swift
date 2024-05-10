//
//  WeatherView.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/9/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @StateObject var network = Network()
    @State private var isPresentingDetails = false
    @State private var showErrorAlert = false
    @State private var showNoConnectionAlert = false
    @State private var showNoInputAlert = false

    var body: some View {
        VStack {
            Text("Quick Weather")
                .padding(40)
                .font(.largeTitle)
                .accessibilityAddTraits(.isHeader)

            Text("Please enter the City name, and select the Country, then hit the button to start.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                .font(.subheadline)
                .accessibilityAddTraits(.isStaticText)

            // Text field for the user to enter the city
            TextField(text: $viewModel.inputText) {
                Text("Fort Worth")
            }
            .padding(.horizontal, 40)
            .textFieldStyle(.roundedBorder)
            .accessibilityIdentifier("Text field")
            .keyboardType(.asciiCapable)

            // Picker for the user to select the country
            Picker("Select a Country", selection: $viewModel.selectedCountry) {
                    ForEach(viewModel.countries, id: \.self) { country in
                        Text(country.name).tag(country)
                    }
            }
            .accessibilityIdentifier("Country Picker")

            Spacer().frame(height: 30)

            HStack() {
                Spacer()

                // Picker to let the user select the Units (Fº or Cº)
                Picker("Select a Unit", selection: $viewModel.unitSelected) {
                    Text("Fº").tag(0)
                    Text("Cº").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(width: 100)
                .padding(.trailing, 25)
                .accessibilityIdentifier("Units Picker")
            }

            Spacer().frame(height: 100)

            createButton()

            Spacer()
        }
        .background()
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            network.checkConnection()
            viewModel.getCountries()
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
        .fullScreenCover(isPresented: $isPresentingDetails) {
            DetailsView(viewModel: viewModel)
        }
        .alert("There is no information available. Please make sure the City and Country are correct and try again.", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        }
        .alert("There is no connnection available. Please confirm you're connected to the internet and try again.", isPresented: $showNoConnectionAlert) {
            Button("OK", role: .cancel) { }
        }
        .alert("Please enter a City name to continue.", isPresented: $showNoInputAlert) {
            Button("OK", role: .cancel) { }
        }
    }

    private func createButton() -> some View {
        Button("Get Current Weather") {
            if viewModel.inputText.isEmpty {
                showNoInputAlert = true
            } else if !network.connected {
                showNoConnectionAlert = true
            } else {
                Task {
                    await viewModel.getWeather()
                    if viewModel.isError {
                        showErrorAlert = true
                    } else {
                        isPresentingDetails = true
                    }
                }
            }
        }
        .padding()
        .foregroundColor(.blue)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.blue.opacity(0.2))
        )
        .accessibilityAddTraits(.isButton)
    }
    
    /// Dismisses the keyboard if the user taps ourside the textField
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    let url = Bundle.main.url(forResource: "response", withExtension: "json")
    let data = try? Data(contentsOf: url!)
    let model = try? JSONDecoder().decode(WeatherModel.self, from: data!)
    return WeatherView(viewModel: WeatherViewModel(weather: model!))
}
