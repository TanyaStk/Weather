//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Hourly
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    private static var tempFormatter: NumberFormatter {
        let tempFormatter = NumberFormatter()
        tempFormatter.maximumFractionDigits = 0
        return tempFormatter
    }
    
    var date: String {
        Self.dateFormatter.string(from: forecast.dt)
    }
    
    var temp: String { "\(Self.tempFormatter.string(for: (forecast.main.temp - 273.5)) ?? "0")°C"
    }
    
    var prussure: String {
        "\(forecast.main.pressure)hPa"
    }
    
    var humidity: String {
        "\(forecast.main.humidity)%"
    }
    
    var weatherDescription: String {
        "\(forecast.weather[0].description)"
    }
    
    var pop: String {
        "\(forecast.pop)mm"
    }
    
    var windSpeed: String {
        "\(forecast.wind.speed)km/h"
    }
}
