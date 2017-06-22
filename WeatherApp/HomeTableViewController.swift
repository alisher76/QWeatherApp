//
//  HomeTableViewController.swift
//  WeatherApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit
import CoreLocation

class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var forecastData: [Weather] = []
    var currentLocation: String? 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateWeatherForLocation(location: "New York")
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
        }
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        
    }
    
    func updateWeatherForLocation(location: String)  {
        CLGeocoder().geocodeAddressString(location) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                if let _location = placemarks?.first?.location {
                    Weather.forecast(withLocation: _location.coordinate, completion: { (results) in
                        if let weatherData = results {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.currentLocation = location
                                self.tableView.reloadData()
                                }
                        }
                    })
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        
        return currentLocation
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.weatherData = forecastData
        return cell
    }
    

    

}
