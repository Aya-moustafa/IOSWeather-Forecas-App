//
//  HomeViewModel.swift
//  Weatherly
//
//  Created by Aya Mostafa on 19/05/2024.
//
import Foundation
import SwiftUI
import Combine
import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var weatherRespond: Weather?
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var theme = HandleThem()
    var network: ApiService?
    private var cancellables = Set<AnyCancellable>()
    
    init(network: ApiService? = nil) {
        self.network = network
        locationManager.$userLocation
            .sink { [weak self] location in
                guard let self = self, let location = location else { return }
                self.fetchWeatherData(for: location)
            }
            .store(in: &cancellables)
    }
       
    func fetchWeatherData(for location: CLLocation) {
        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)
        ApiService.fetchWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weathercast):
                print("Received weather: \(weathercast.location.name ?? "Unknown")")
                DispatchQueue.main.async {
                    self.weatherRespond = weathercast
                }
            case .failure(let error):
                print("Error fetching weather: \(error)")
            }
        }
    }
       
    func getWeather() -> Weather? {
        return weatherRespond
    }
}
