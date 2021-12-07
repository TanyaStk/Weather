//
//  ForecastPresenter.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 05.12.2021.
//

import Foundation
import UIKit

protocol ForecastCellView {
    func display(image: String)
    func display(time: String)
    func display(description: String)
    func display(temp: String)
}

protocol ForecastPresenterDelegate: AnyObject {
}

typealias ForecastPD = ForecastPresenterDelegate & UIViewController

class ForecastPresenter {
    
    weak private var delegate: ForecastPD?
    
    private var forecast = [[ForecastModel]]()

    func setViewDelegate(delegate: ForecastPD) {
        self.delegate = delegate
    }
    
    func setForecast(forecast: [[ForecastModel]]) {
        self.forecast = forecast
    }
    
    var numberOfSections: Int {
        forecast.count
    }

    func numberOfRows(in section: Int) -> Int {
        forecast[section].count
    }
    
    func headerInSection(section: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, YYYY"
        
        return dateFormatter.weekdaySymbols[Calendar.current.component(
            .weekday, from: forecast[section].first?.date ?? Date()) - 1]
    }

    func configure(cell: ForecastCellView, for indexPath: IndexPath) {
        let forecast = forecast[indexPath.section][indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        cell.display(image: forecast.icon)
        cell.display(time: dateFormatter.string(from: forecast.date))
        cell.display(description: forecast.weatherDescription)
        cell.display(temp: forecast.temp)
    }
    
}
