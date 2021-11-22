//
//  ViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import UIKit

class TodayViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempAndDescrLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    @IBAction func shareForecastAsText(_ sender: UIButton) {
        let textShare = [ today ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    var today = ForecastViewModel.init(forecast: Forecast.Hourly(dt: Date(), main: Forecast.Hourly.Main(temp: 0, pressure: 0, humidity: 0), weather: [], wind: Forecast.Hourly.Wind.init(speed: 0, deg: 0), pop: 0))
    var location: String = "City name, Country"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTodayUI()
    }
    
    private func setupTodayUI() {
        self.locationLabel?.text = self.location
        self.tempAndDescrLabel?.text = "\(self.today.temp)C | \(self.today.weatherDescription)"
        self.weatherImage?.image = UIImage(named: self.today.icon)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.humidityLabel.text = self.today.humidity
        self.popLabel.text = self.today.pop
        self.pressureLabel.text = self.today.prussure
        self.windSpeedLabel.text = self.today.windSpeed
        self.windDirectionLabel.text = self.today.windDirection
    }
}
