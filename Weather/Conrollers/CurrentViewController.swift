//
//  ViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import UIKit

class CurrentViewController: UIViewController, UITabBarControllerDelegate, ForecastPresenterDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempAndDescrLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    @IBAction func shareForecastAsText(_ sender: UIButton) {
        let textShare = [forecast.description]
        let activityViewController = UIActivityViewController(activityItems: textShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private let presenter = ForecastPresenter()
    
    private var forecast = [ForecastViewModel]()
    private var location: String = "City name, Country"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            if NetworkMonitor.shared.isConnected {
                self.tabBarController?.delegate = self
                self.presenter.setViewDelegate(delegate: self)
            }
            else {
                if let networkVC = self.storyboard?
                    .instantiateViewController(withIdentifier: "NetworkConnection") as? NetworkConnectionViewController {
                    self.present(networkVC, animated: true)
                }
            }
        }
    }
    
    func presentCurrent(forecast: [ForecastViewModel]) {
        self.forecast = forecast
        
        DispatchQueue.main.async {
            self.setupTodayUI()
        }
    }
    
    func presentLocation(location: String) {
        self.location = location
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            let viewController  = tabBarController.viewControllers?[1] as! ForecastViewController
            viewController.groupedForecasts = presenter.prepareDataForForecastVC()
        }
    }
    
    public func setupTodayUI() {
        guard let today = forecast.first else {
            return
        }
        self.locationLabel?.text = location
        self.tempAndDescrLabel?.text = "\(today.temp)C | \(today.weatherDescription)"
        self.weatherImage?.image = UIImage(named: today.icon)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.humidityLabel.text = today.humidity
        self.popLabel.text = today.pop
        self.pressureLabel.text = today.pressure
        self.windSpeedLabel.text = today.windSpeed
        self.windDirectionLabel.text = today.windDirection
    }
}
