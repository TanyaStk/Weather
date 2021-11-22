//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Hourly

    private static var tempFormatter: NumberFormatter {
        let tempFormatter = NumberFormatter()
        tempFormatter.maximumFractionDigits = 0
        return tempFormatter
    }
    
    var date: Date {
        return forecast.dt
    }
    
    var temp: String {
        return "\(Int(forecast.main.temp))°"
    }
    
    var icon: String {
        forecast.weather[0].description
    }
    
    var prussure: String {
        "\(forecast.main.pressure) hPa"
    }
    
    var humidity: String {
        "\(forecast.main.humidity) %"
    }
    
    var weatherDescription: String {
        "\(forecast.weather[0].description)".firstUppercased
    }
    
    var pop: String {
        "\(forecast.pop) mm"
    }
    
    var windSpeed: String {
        "\(forecast.wind.speed) km/h"
    }
    
    var windDirection: String {
        "\(forecast.wind.deg)"
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
