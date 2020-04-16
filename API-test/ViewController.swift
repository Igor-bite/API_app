//
//  ViewController.swift
//  API-test
//
//  Created by Игорь Клюжев on 15.04.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var segmentTemp: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

}

open class UIControlEventValueChanged {
    func segmentChanged(_ segmentTemp: UISegmentedControl ) {
        if (segmentTemp.selectedSegmentIndex == 1) {
            
        } else if (segmentTemp.selectedSegmentIndex == 2) {
            
        } else if (segmentTemp.selectedSegmentIndex == 3) {
            
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        segmentTemp.selectedSegmentIndex = 1
        
        self.parse_ID();
    }
    
    func parse_ID() {
        let urlString = "https://www.metaweather.com/api/location/search/?query=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        
        var locationName: String?
        var locationID: Int?
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {

                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String : AnyObject]]
                if json.isEmpty {
                    DispatchQueue.main.async {
                        self?.cityLabel.text = "Not found"
                        self?.tempLabel.isHidden = true
                    }
                } else {
                    locationID = json[0]["woeid"] as! Int?
                    locationName = json[0]["title"] as! String?
                    
                    let mainUrlString = "https://www.metaweather.com/api/location/\(locationID!)"
                    let mainUrl = URL(string: mainUrlString)
                    
                    self?.parse_temp(locationName: locationName, mainUrl: mainUrl);
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
    
    func parse_temp(locationName: String?, mainUrl: URL?) {
        var temperature: Double?
        var humidity: Double?
        var visibility: Double?
        var wind_speed: Double?
        var errorHasOccured: Bool = false
        
        let mainTask = URLSession.shared.dataTask(with: mainUrl!) { [weak self] (data1, response1, error1) in
            do {
                
                let mainJson = try JSONSerialization.jsonObject(with: data1!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                if mainJson.isEmpty {
                    errorHasOccured = true
                }
                
                let consolidated_weather = mainJson["consolidated_weather"] as! [[String : AnyObject]]?
                temperature = consolidated_weather?[0]["the_temp"] as! Double?
                humidity = consolidated_weather?[0]["humidity"] as! Double?
                visibility = consolidated_weather?[0]["visibility"] as! Double?
                wind_speed = consolidated_weather?[0]["wind_speed"] as! Double?
                
                self?.Display(locationName: locationName, temperature: temperature, humidity: humidity, visibility: visibility, wind_speed: wind_speed, errorHasOccured: errorHasOccured);
                
            }
            catch let jsonError1 {
                print(jsonError1)
            }
        }
        mainTask.resume()
    }
    
    func parse_min_temp(locationName: String?, mainUrl: URL?) {
        var temperature: Double?
        var humidity: Double?
        var visibility: Double?
        var wind_speed: Double?
        var errorHasOccured: Bool = false

        let mainTask = URLSession.shared.dataTask(with: mainUrl!) { [weak self] (data1, response1, error1) in
            do {
                
                let mainJson = try JSONSerialization.jsonObject(with: data1!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                if mainJson.isEmpty {
                    errorHasOccured = true
                }
                
                let consolidated_weather = mainJson["consolidated_weather"] as! [[String : AnyObject]]?
                temperature = consolidated_weather?[0]["min_temp"] as! Double?
                humidity = consolidated_weather?[0]["humidity"] as! Double?
                visibility = consolidated_weather?[0]["visibility"] as! Double?
                wind_speed = consolidated_weather?[0]["wind_speed"] as! Double?
                
                self?.Display(locationName: locationName, temperature: temperature, humidity: humidity, visibility: visibility, wind_speed: wind_speed, errorHasOccured: errorHasOccured);
                
            }
            catch let jsonError1 {
                print(jsonError1)
            }
        }
        mainTask.resume()
    }
    
    func parse_max_temp(locationName: String?, mainUrl: URL?) {
            var temperature: Double?
            var humidity: Double?
            var visibility: Double?
            var wind_speed: Double?
            var errorHasOccured: Bool = false

            let mainTask = URLSession.shared.dataTask(with: mainUrl!) { [weak self] (data1, response1, error1) in
                do {
                    
                    let mainJson = try JSONSerialization.jsonObject(with: data1!, options: .mutableContainers)
                        as! [String : AnyObject]
                    
                    if mainJson.isEmpty {
                        errorHasOccured = true
                    }
                    
                    let consolidated_weather = mainJson["consolidated_weather"] as! [[String : AnyObject]]?
                    temperature = consolidated_weather?[0]["max_temp"] as! Double?
                    humidity = consolidated_weather?[0]["humidity"] as! Double?
                    visibility = consolidated_weather?[0]["visibility"] as! Double?
                    wind_speed = consolidated_weather?[0]["wind_speed"] as! Double?
                    
                    self?.Display(locationName: locationName, temperature: temperature, humidity: humidity, visibility: visibility, wind_speed: wind_speed, errorHasOccured: errorHasOccured);
                    
                }
                catch let jsonError1 {
                    print(jsonError1)
                }
            }
            mainTask.resume()
        }
    
    func Display(locationName: String?, temperature: Double?,humidity: Double?,visibility: Double?,wind_speed: Double?,errorHasOccured: Bool) {
        DispatchQueue.main.async {
            if errorHasOccured{
                self.cityLabel.text = "Not found"
                self.tempLabel.isHidden = true
            } else {
                self.cityLabel.text = locationName!
                self.tempLabel.text = "\(round(temperature!*10)/10) C"
                self.humidityLabel.text = "\(humidity!)%"
                self.windSpeedLabel.text = "\(round(wind_speed!*10)/10) m/s"
                self.visibilityLabel.text = "\(round(visibility!*10)/10) m"
                self.tempLabel.isHidden = false
            }
        }
    }
}


