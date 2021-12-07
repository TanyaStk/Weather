//
//  ForecastViewController.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 20.11.2021.
//

import UIKit
import SwiftUI

class ForecastViewController: UIViewController, ForecastPresenterDelegate {
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    let cellHeight = CGFloat(40)
    var groupedForecasts = [[ForecastModel]]()
    
    private let presenter = ForecastPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.presenter.setForecast(forecast: self.groupedForecasts)
        }
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as! ForecastTableViewCell
        presenter.configure(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width), height: Int(self.cellHeight)))
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width, height: self.cellHeight))
        switch section {
        case 0: label.text = "Today"
        case 1: label.text = "Tomorrow"
        default:
            label.text = presenter.headerInSection(section: section)
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.cellHeight
    }
}
