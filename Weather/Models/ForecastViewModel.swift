//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import Foundation

struct ForecastViewModel {
    let forecast: ForecastRequest.Hourly

    private static var windSpeedFormatter: NumberFormatter {
        let tempFormatter = NumberFormatter()
        tempFormatter.maximumFractionDigits = 1
        return tempFormatter
    }
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    private enum windDirections {
        case N, NE, E, SE, S, SW, W, NW
    }
    
    var date: Date {
        return Self.dateFormatter.date(from: forecast.dt_txt) ?? Date()
    }
    
    var temp: String {
        "\(Int(forecast.main.temp))°"
    }
    
    var icon: String {
        forecast.weather[0].description
    }
    
    var pressure: String {
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
        "\(Self.windSpeedFormatter.string(for: forecast.wind.speed * 3.6) ?? "0") km/h"
    }
    
    var windDirection: String {
        let intWindDegree = Int(forecast.wind.deg)
        switch intWindDegree {
        case 11 ... 348:
            return "\(windDirections.N)"
        case 33 ... 56:
            return "\(windDirections.NE)"
        case 78 ... 101:
            return "\(windDirections.E)"
        case 123 ... 146:
            return "\(windDirections.SE)"
        case 168 ... 191:
            return "\(windDirections.S)"
        case 213 ... 236:
            return "\(windDirections.SW)"
        case 258 ... 281:
            return "\(windDirections.W)"
        case 303 ... 326:
            return "\(windDirections.NW)"
        default:
            return "\(forecast.wind.deg )"
        }
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
