//
//  ForecastListViewModel.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import Foundation
import CoreLocation

class ForecastListViewModel: NSObject {
    @Published var forecasts: [ForecastViewModel] = []
    @Published var location: String = "City name, Country"
    
    private let forecastService = ForecastService()
    private let locationManager = CLLocationManager()
    private var completionHandler: ((Forecast) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension ForecastListViewModel: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let forecastService = ForecastService.shared
        guard let location = locations.first else { return }
        forecastService.weatherForecastForCoordinates(lat: location.coordinate.latitude,
                                      lon: location.coordinate.longitude) {
            (result: Swift.Result<Forecast, ForecastService.APIError>) in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.forecasts = forecast.list.map {
                        ForecastViewModel(forecast: $0)
                    }
                    self.location = "\(forecast.city.name), \(forecast.city.country)"
                }
            case .failure(let apiError):
                switch apiError{
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}

extension ForecastListViewModel: ObservableObject {
    
}
