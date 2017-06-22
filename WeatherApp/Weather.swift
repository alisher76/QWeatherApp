//
//  Weather.swift
//  WeatherApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation
import CoreLocation


struct Weather {
    let summary: String
    let icon: String
    let temperature: Double
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("Summary is misssing")}
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("Icon is missing")}
        
        guard let temperature = json["temperatureMax"] as? Double else {throw SerializationError.missing("Temperature is missing")}
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
    }
    
    static let basePath = "https://api.darksky.net/forecast/68ca4f667d62dcd62c753ff4f235ebdc/"
    
    static func forecast(withLocation location: CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, responce: URLResponse?, error: Error?) in
            var forecastArray: [Weather] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                        print(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
    }
}
