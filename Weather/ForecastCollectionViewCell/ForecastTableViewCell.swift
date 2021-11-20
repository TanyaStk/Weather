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
    
    func setupCellUI(forecast: ForecastViewModel){
//        forecastImage.image = forecast.image
        timeLabel.text = forecast.date
        descriptionLabel.text = forecast.weatherDescription
        tempLabel.text = forecast.temp
    }

}
