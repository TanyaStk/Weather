//
//  ForecastViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 20.11.2021.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecast: [ForecastViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        var numberOfSections = 1
//        for hourlyIndex in 1...forecast.count {
//            if !Calendar.current.isDate(forecast[hourlyIndex - 1].date, inSameDayAs: forecast[hourlyIndex].date) {
//                numberOfSections += 1
//            }
//        }
//        return numberOfSections
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var numberOfSections = 1
//        for hourlyIndex in 1...forecast.count {
//            if Calendar.current.isDate(forecast[hourlyIndex - 1].date, inSameDayAs: forecast[hourlyIndex].date) {
//                numberOfSections += 1
//            }
//        }
//        return numberOfSections
        return forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as! ForecastTableViewCell
        cell.setupCellUI(forecast: forecast[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forecast[section].date.formatted()
    }
}
