//
//  ForecastService.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftUI

class ForecastService {
    
    static let shared = ForecastService()
    
    private let API_KEY = "364db8877eb51476a00e441bbcfb902d"
    private let forecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast?"
    
    public enum APIError: Error{
        case error(_ errorString: String)
    }
    
    public func weatherForecastForCoordinates<T: Decodable>(lat: Double, lon: Double,
                                                             dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                                             keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                                             completion: @escaping (Swift.Result<T, APIError>) -> Void){
        let stringUrl = "\(self.forecastBaseURL)lat=\(lat)&lon=\(lon)&appid=\(self.API_KEY)&units=metric"
        guard let forecastUrl = URL(string: stringUrl) else { return }
        Alamofire.request(forecastUrl).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(_):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = dateDecodingStrategy
                    decoder.keyDecodingStrategy = keyDecodingStrategy
                    let res = try decoder.decode(T.self, from: response.data!)
                    completion(.success(res))
                }catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }).resume()
    }
}


