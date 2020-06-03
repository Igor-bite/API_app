//
//  Parsing.swift
//  API-test
//
//  Created by Игорь Клюжев on 03.06.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension ViewController {
    func parse_ID(ind: Int?) {
        let urlString = "https://www.metaweather.com/api/location/search/?query=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        
        var locationName: String?
        var locationID: Int?
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {

                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String : AnyObject]]
                if json.isEmpty {
                    self!.Display(locationName: nil, temperature: nil, humidity: nil, visibility: nil, wind_speed: nil, errorHasOccured: true)
                } else {
                    locationID = json[0]["woeid"] as! Int?
                    locationName = json[0]["title"] as! String?
                    
                    let mainUrlString = "https://www.metaweather.com/api/location/\(locationID!)"
                    let mainUrl = URL(string: mainUrlString)
                    
                    if (ind == 0) {
                        self?.parse_min_temp(locationName: locationName, mainUrl: mainUrl);
                    } else if (ind == 1) {
                        self?.parse_temp(locationName: locationName, mainUrl: mainUrl);
                    } else if (ind == 2) {
                        self?.parse_max_temp(locationName: locationName, mainUrl: mainUrl);
                    }
                    
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
}

extension SecondViewController {
    func get_picture(weather: String?) {
        let url_string = "https:\(weather!)"
        let request = URL(string: url_string)
        DispatchQueue.main.async {
            if let data1 = try? Data(contentsOf: request!)
            {
                self.weather.image = UIImage(data: data1)
            }
        }
        
    }
    
    func get_background() {
        let urlString = "https://picsum.photos/1200/2000?blur=5"
        let url = URL(string: urlString)
        
        if let data = try? Data(contentsOf: url!)
        {
            self.picture.image = UIImage(data: data)
        }
    }
    
    func request_for_current(longtitude: Double, latitude: Double) {
        let api_key = "7b4dea03efcf489bb54174029201804"
        let string = "https://api.weatherapi.com/v1/current.json?key=\(api_key)&q=\(latitude),\(longtitude)"
        let url = URL(string: string)
        print(string)
        var temperature: Double?
        var feels_like_text: Double?
        var humidity: Double?
        var visibility: Double?
        var wind_speed: Double?
        var photo_url: String?
        var description: String?
        var cityName: String?
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                as! [String : [String : AnyObject]]
                
                var current = json["current"] as! [String : AnyObject]?
                var location = json["location"] as! [String : AnyObject]?
                
                cityName = location?["region"] as! String?
                
                temperature = current?["temp_c"] as! Double?
                humidity = current?["humidity"] as! Double?
                visibility = current?["vis_km"] as! Double?
                wind_speed = current?["wind_kph"] as! Double?
                feels_like_text = current?["feelslike_c"] as! Double?

                var condition = current?["condition"] as! [String : AnyObject]?
                photo_url = condition!["icon"] as! String?
                description = condition!["text"] as! String?
                
                self.get_picture(weather: photo_url)
                manager.stopUpdatingLocation()
                
                DispatchQueue.main.async {
                    self.temp.text = "\(temperature!) C"
                    self.feels_like.text = "\(feels_like_text!) C"
                    self.describe.text = description
                    self.humidity_label.text = "\(humidity!)%"
                    self.wind_label.text = "\(wind_speed!) m/s"
                    self.visibility_label.text = "\(visibility!) km"
                    self.cityLabel.text = "\(cityName!)"
                    self.temp.isHidden = false
                    self.feels_like.isHidden = false
                    self.describe.isHidden = false
                    self.humidity_label.isHidden = false
                    self.wind_label.isHidden = false
                    self.visibility_label.isHidden = false
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
    
    func request_for_spb() {
        let api_key = "7b4dea03efcf489bb54174029201804"
        let string = "https://api.weatherapi.com/v1/current.json?key=\(api_key)&q=Saint%20Petersburg"
        let url = URL(string: string)
        
        var temperature: Double?
        var feels_like_text: Double?
        var humidity: Double?
        var visibility: Double?
        var wind_speed: Double?
        var photo_url: String?
        var description: String?
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                as! [String : [String : AnyObject]]
                
                var current = json["current"] as! [String : AnyObject]?
                
                temperature = current?["temp_c"] as! Double?
                humidity = current?["humidity"] as! Double?
                visibility = current?["vis_km"] as! Double?
                wind_speed = current?["wind_kph"] as! Double?
                feels_like_text = current?["feelslike_c"] as! Double?

                var condition = current?["condition"] as! [String : AnyObject]?
                photo_url = condition!["icon"] as! String?
                description = condition!["text"] as! String?
                                
                self.get_picture(weather: photo_url)
                
                DispatchQueue.main.async {
                    self.temp.text = "\(temperature!) C"
                    self.feels_like.text = "\(feels_like_text!) C"
                    self.describe.text = description
                    self.humidity_label.text = "\(humidity!)%"
                    self.wind_label.text = "\(wind_speed!) m/s"
                    self.visibility_label.text = "\(visibility!) km"
                    
                    self.temp.isHidden = false
                    self.feels_like.isHidden = false
                    self.describe.isHidden = false
                    self.humidity_label.isHidden = false
                    self.wind_label.isHidden = false
                    self.visibility_label.isHidden = false
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
    
}
