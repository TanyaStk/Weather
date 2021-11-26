//
//  Forecast.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import Foundation

struct ForecastRequest: Codable {
    struct Hourly: Codable {
        let dt_txt: String
        
        struct Main: Codable {
            let temp: Double
            let pressure: Int
            let humidity: Int
        }
        let main: Main
        
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
        }
        let weather: [Weather]
        
        struct Wind: Codable {
            let speed: Double
            let deg: Int
        }
        let wind: Wind
        
        let pop: Double
    }
    
    let list : [Hourly]
    
    struct City: Codable {
        let name: String
        let country: String
    }
    
    let city: City
}

