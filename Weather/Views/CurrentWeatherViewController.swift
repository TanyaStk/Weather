//
//  ViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import UIKit

class CurrentWeatherViewController: UIViewController, UITabBarControllerDelegate, CurrentPresenterDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempAndDescrLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    @IBAction func shareForecastAsText(_ sender: UIButton) {
        let textShare = presenter.shareForecastAsText()
        let activityViewController = UIActivityViewController(activityItems: textShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private let presenter = CurrentWeatherPresenter()
    
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
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            let viewController  = tabBarController.viewControllers?[1] as! ForecastViewController
            viewController.groupedForecasts = presenter.prepareDataForForecastVC()
        }
    }
    
    func display(location: String) {
        locationLabel.text = location
    }
    
    func display(temp: String, description: String) {
        tempAndDescrLabel?.text = "\(temp)C | \(description)"
    }
    
    func display(weatherImage: String) {
        self.weatherImage?.image = UIImage(named: weatherImage)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    func display(humidity: String) {
        humidityLabel.text = humidity
    }
    
    func display(pop: String) {
        popLabel.text = pop
    }
    
    func display(pressure: String) {
        pressureLabel.text = pressure
    }
    
    func display(windSpeed: String) {
        windSpeedLabel.text = windSpeed
    }
    
    func display(windDirection: String) {
        windDirectionLabel.text = windDirection
    }
}
