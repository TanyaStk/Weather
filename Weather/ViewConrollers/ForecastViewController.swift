//
//  ForecastViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 20.11.2021.
//

import UIKit
import SwiftUI

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var grouptedForecasts: [[ForecastViewModel]] = [[]]
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "EEEE, MMMM dd, YYYY"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return grouptedForecasts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grouptedForecasts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as! ForecastTableViewCell
        cell.setupCellUI(forecast: grouptedForecasts[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Today"
        case 1: return "Tomorrow"
        default:
            return DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: grouptedForecasts[section].first?.date ?? Date()) - 1]
        }
    }
}
