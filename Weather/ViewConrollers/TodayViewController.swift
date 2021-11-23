//
//  ViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import UIKit

class TodayViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempAndDescrLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    @IBAction func shareForecastAsText(_ sender: UIButton) {
        let textShare = [ forecasts.description ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private let locationManeger = LocationManager.shared

    var forecasts: [ForecastViewModel] = []
    var location: String = "City name, Country"

    private var lat: Double?
    private var lon: Double?{
        didSet {
            self.setupWeather()
        }
    }
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.delegate = self
        
        locationManeger.setupLocationManager()
        locationManeger.didUpdatedLocation = { [self] in
            if locationManeger.lat != nil {
                lat = locationManeger.lat
                lon = locationManeger.lon
            } else {
                lat = 0
                lon = 0
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            let viewController  = tabBarController.viewControllers?[1] as! ForecastViewController
            viewController.groupedForecasts = self.prepareDataForForecastVC()
        }
    }

    private func prepareDataForForecastVC() -> [[ForecastViewModel]]{
        var groupedForecasts : [[ForecastViewModel]] = [[]]
        let forecastDict = Dictionary(grouping: forecasts) {Self.dateFormatter.string(from: $0.date)}
        let sortedForecast = forecastDict.sorted{ (Self.dateFormatter.date(from: $0.key) ?? Date()) < (Self.dateFormatter.date(from: $1.key) ?? Date())
        }
        for key in sortedForecast {
            groupedForecasts.append(key.value)
        }
        return groupedForecasts
    }
    
    private func setupWeather() {
        ForecastService.shared.weatherForecastForCoordinates(lat: lat ?? 0, lon: lon ?? 0) {
            (result: Swift.Result<Forecast, ForecastService.APIError>) in
            switch result {
            case .success(let forecast):
                self.forecasts = forecast.list.map {
                    ForecastViewModel(forecast: $0)
                }
                self.location = "\(forecast.city.name), \(forecast.city.country)"
                self.setupTodayUI()
            case .failure(let apiError):
                switch apiError{
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }

    public func setupTodayUI() {
        guard let today = forecasts.first else {
            return
        }
        self.locationLabel?.text = self.location
        self.tempAndDescrLabel?.text = "\(today.temp)C | \(today.weatherDescription)"
        self.weatherImage?.image = UIImage(named: today.icon)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.humidityLabel.text = today.humidity
        self.popLabel.text = today.pop
        self.pressureLabel.text = today.pressure
        self.windSpeedLabel.text = today.windSpeed
        self.windDirectionLabel.text = today.windDirection
    }
}
