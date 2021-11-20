//
//  ViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempAndDescrLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!

    var forecasts: [ForecastViewModel] = []
    var location: String = "City name, Country"
    private let locationManeger = LocationManager.shared
    private var lat: Double?
    private var lon: Double? {
        didSet {
            showWeather()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManeger.setupLocationManager()
        locationManeger.didUpdatedLocation = { [self] in
            if locationManeger.lat != nil {
                lat = locationManeger.lat
                lon = locationManeger.lon
            } else {
                lat = 41.850029
                lon = -87.650047
            }
        }
    }

    private func showWeather() {
        ForecastService.shared.weatherForecastForCoordinates(lat: lat ?? 0, lon: lon ?? 0) {
            (result: Swift.Result<Forecast, ForecastService.APIError>) in
            switch result {
            case .success(let forecast):
                self.forecasts = forecast.list.map {
                    ForecastViewModel(forecast: $0)
                }
                self.location = "\(forecast.city.name), \(forecast.city.country)"
                self.setupForecastUI()
            case .failure(let apiError):
                switch apiError{
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    private func setupForecastUI() {
        self.locationLabel?.text = self.location
        self.tempAndDescrLabel?.text = "\(self.forecasts[0].temp) | \(self.forecasts[0].weatherDescription)"
        self.weatherImage?.image = UIImage(systemName: "sun.max")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.humidityLabel.text = self.forecasts[0].humidity
        self.popLabel.text = self.forecasts[0].pop
        self.pressureLabel.text = self.forecasts[0].prussure
        self.windSpeedLabel.text = self.forecasts[0].windSpeed
        self.windDirectionLabel.text = self.forecasts[0].windDirection
    }
}
