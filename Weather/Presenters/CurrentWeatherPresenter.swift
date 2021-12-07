//
//  ViewModel.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 26.11.2021.
//

import Foundation
import UIKit

protocol CurrentPresenterDelegate: AnyObject {
    func display(location: String)
    func display(temp: String, description: String)
    func display(weatherImage: String)
    func display(humidity: String)
    func display(pop: String)
    func display(pressure: String)
    func display(windSpeed: String)
    func display(windDirection: String)
}

typealias CurrentPD = CurrentPresenterDelegate & UIViewController

class CurrentWeatherPresenter {
    
    weak private var delegate: CurrentPD?
    
    private let locationManeger = LocationManager.shared
    
    private var forecast: [ForecastModel] = []
    private var location: String = ""
    
    private var lat: Double?
    private var lon: Double?{
        didSet {
            self.setupWeather()
        }
    }

    func setupLocation() {
        locationManeger.setupLocationManager()
        locationManeger.didUpdatedLocation = { [self] in
            if locationManeger.lat != nil {
                lat = locationManeger.lat
                lon = locationManeger.lon
            } else {
                lat = 0
                lon = 0
            }
        }
    }
    
    private func setupWeather() {
        ForecastService.shared.weatherForecastForCoordinates(
            lat: lat ?? 0, lon: lon ?? 0) {
            (result: Swift.Result<ForecastRequest, ForecastService.APIError>) in
            switch result {
            case .success(let forecast):
                self.forecast = forecast.list.map {
                    ForecastModel(forecast: $0)
                }
                self.location = "\(forecast.city.name), \(forecast.city.country)"
                self.delegate?.display(location: self.location)
                self.displayCurrentWeather()
                
            case .failure(let apiError):
                switch apiError{
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    func prepareDataForForecastVC() -> [[ForecastModel]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        var groupedForecasts = [[ForecastModel]]()
        let forecastDict = Dictionary(grouping: forecast) {dateFormatter.string(from: $0.date)}
        let sortedForecast = forecastDict.sorted{
            (dateFormatter.date(from: $0.key) ?? Date()) < (dateFormatter.date(from: $1.key) ?? Date())
        }
        for key in sortedForecast {
            groupedForecasts.append(key.value)
        }
        return groupedForecasts
    }
    
    func setViewDelegate(delegate: CurrentPD) {
        self.delegate = delegate
        self.setupLocation()
    }
    
    func displayCurrentWeather() {
        guard let currentWeather = forecast.first else { return }
        delegate?.display(location: location)
        delegate?.display(temp: currentWeather.temp, description: currentWeather.weatherDescription)
        delegate?.display(weatherImage: currentWeather.icon)
        delegate?.display(pop: currentWeather.pop)
        delegate?.display(humidity: currentWeather.humidity)
        delegate?.display(pressure: currentWeather.pressure)
        delegate?.display(windSpeed: currentWeather.windSpeed)
        delegate?.display(windDirection: currentWeather.windDirection)
    }
    
    func shareForecastAsText() -> [String] {
        [forecast.description]
    }
}
