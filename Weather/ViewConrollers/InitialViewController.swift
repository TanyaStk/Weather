//
//  InitialViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 22.11.2021.
//

import UIKit

class InitialViewController: UIViewController {

//    @IBOutlet weak var Title: UILabel!
    
    @IBAction func showForecastListButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "forecastList") as! ForecastViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    var forecasts: [ForecastViewModel] = []
    var location: String = "City name, Country"
    
    private let locationManeger = LocationManager.shared
    private var lat: Double?
    private var lon: Double? {
        didSet {
            setupWeather()
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
                lat = 0
                lon = 0
            }
        }
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
            case .failure(let apiError):
                switch apiError{
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TodayViewController {
            vc.today = forecasts[0]
            vc.location = location
        } else if let vc = segue.destination as? ForecastViewController {
            var grouptedForecasts : [[ForecastViewModel]] = [[]]
            let forecastDict = Dictionary(grouping: forecasts) {Self.dateFormatter.string(from: $0.date)}
            let sortedForecast = forecastDict.sorted{ (Self.dateFormatter.date(from: $0.key) ?? Date()) < (Self.dateFormatter.date(from: $1.key) ?? Date())
            }
            for key in sortedForecast {
                grouptedForecasts.append(key.value)
            }
            vc.grouptedForecasts = grouptedForecasts
        }
    }
}
