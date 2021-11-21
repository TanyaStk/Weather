//
//  ForecastCollectionViewCell.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 20.11.2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastTableViewCell"

    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
    
    func setupCellUI(forecast: ForecastViewModel){
        forecastImage.image = UIImage(named: forecast.icon)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        timeLabel.text = Self.dateFormatter.string(from: forecast.date)
        descriptionLabel.text = forecast.weatherDescription
        tempLabel.text = forecast.temp
    }

}
