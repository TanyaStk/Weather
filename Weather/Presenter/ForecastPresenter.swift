//
//  ViewModel.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 26.11.2021.
//

import Foundation
import UIKit

protocol ForecastPresenterDelegate: AnyObject {
    func presentCurrent(forecast: [ForecastViewModel])
    func presentLocation(location: String)
}

typealias PresenterDelegate = ForecastPresenterDelegate & UIViewController

class ForecastPresenter {
    
    weak var delegate: PresenterDelegate?
    
    private let locationManeger = LocationManager.shared
    
    var forecast: [ForecastViewModel] = []
    var location: String = ""
    
    private var lat: Double?
    private var lon: Double?{
        didSet {
            self.setupWeather()
        }
    }

    public func setupLocation() {
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
        ForecastService.shared.weatherForecastForCoordinates(lat: lat ?? 0, lon: lon ?? 0) {
            (result: Swift.Result<ForecastRequest, ForecastService.APIError>) in
            switch result {
            case .success(let forecast):
                self.forecast = forecast.list.map {
                    ForecastViewModel(forecast: $0)
                }
                self.delegate?.presentCurrent(forecast: self.forecast)
                self.location = "\(forecast.city.name), \(forecast.city.country)"
                self.delegate?.presentLocation(location: self.location)
            case .failure(let apiError):
                switch apiError{
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    public func prepareDataForForecastVC() -> [[ForecastViewModel]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        var groupedForecasts = [[ForecastViewModel]]()
        let forecastDict = Dictionary(grouping: forecast) {dateFormatter.string(from: $0.date)}
        let sortedForecast = forecastDict.sorted{
            (dateFormatter.date(from: $0.key) ?? Date()) < (dateFormatter.date(from: $1.key) ?? Date())
        }
        for key in sortedForecast {
            groupedForecasts.append(key.value)
        }
        return groupedForecasts
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
        self.setupLocation()
    }
    
}
