//
//  ForecastCollectionViewCell.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 20.11.2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell, ForecastCellView {
    static let identifier = "ForecastTableViewCell"

    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func display(image: String) {
        forecastImage.image = UIImage(named: image)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    func display(time: String) {
        timeLabel.text = time
    }
    
    func display(description: String) {
        descriptionLabel.text = description
    }
    
    func display(temp: String) {
        tempLabel.text = temp
    }
}
