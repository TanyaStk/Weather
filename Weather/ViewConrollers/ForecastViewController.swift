//
//  ForecastViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 20.11.2021.
//

import UIKit
import SwiftUI

class ForecastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    let cellHeight = CGFloat(40)
    var groupedForecasts: [[ForecastViewModel]] = [[]]
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "EEEE, MMMM dd, YYYY"
        return dateFormatter
    }
    
//    init(groupedForecasts: [[ForecastViewModel]]) {
//        super.init(nibName: nil, bundle: nil)
//        self.groupedForecasts = groupedForecasts
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedForecasts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedForecasts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as! ForecastTableViewCell
        cell.setupCellUI(forecast: groupedForecasts[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width), height: Int(self.cellHeight)))
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width, height: self.cellHeight))
        switch section {
        case 0: label.text = "Today"
        case 1: label.text = "Tomorrow"
        default: label.text = DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: groupedForecasts[section].first?.date ?? Date()) - 1]
            }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.cellHeight
    }
}

//extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
//
//
//}
