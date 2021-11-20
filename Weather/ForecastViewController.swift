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
    
    private func registerCell() {
        forecastTableView.register(UINib(nibName: ForecastTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ForecastTableViewCell.identifier)
    }
    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
     */

}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as! ForecastTableViewCell
        cell.setupCellUI(forecast: forecast[indexPath.row])
        return cell
    }
}
