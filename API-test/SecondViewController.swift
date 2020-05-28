//
//  SecondViewController.swift
//  API-test
//
//  Created by Игорь Клюжев on 17.04.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import UIKit

let api_key = "e13117e6-789c-4689-882f-f480dbc1418e"

struct advies {
    let partly_cloudy: String = "cloud"
    let overcast: String = "overcast"
    let sunny: String = "sunny"
    let light_rain_shower: String = "shower"
}


class SecondViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var feels_like: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var wind_label: UILabel!
    @IBOutlet weak var humidity_label: UILabel!
    @IBOutlet weak var visibility_label: UILabel!
    @IBOutlet weak var weather: UIImageView!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.temp.isHidden = true
        self.feels_like.isHidden = true
        self.describe.isHidden = true
        self.humidity_label.isHidden = true
        self.wind_label.isHidden = true
        self.visibility_label.isHidden = true
        
        get_background()
        request_for_spb()
        
        self.adviceLabel.text = ""
        
    }
    
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension SecondViewController {
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



/*
 last_updated_epoch": 1587231920,
 "last_updated": "2020-04-18 20:45",
 "temp_c": 2.0,
 "temp_f": 35.6,
 "is_day": 0,
 "condition": {
     "text": "Light rain",
     "icon": "//cdn.weatherapi.com/weather/64x64/night/296.png",
     "code": 1183
 },
 "wind_mph": 18.6,
 "wind_kph": 29.9,
 "wind_degree": 310,
 "wind_dir": "NW",
 "pressure_mb": 1007.0,
 "pressure_in": 30.2,
 "precip_mm": 0.2,
 "precip_in": 0.01,
 "humidity": 87,
 "cloud": 100,
 "feelslike_c": -3.9,
 "feelslike_f": 25.1,
 "vis_km": 9.0,
 "vis_miles": 5.0,
 "uv": 1.0,
 "gust_mph": 19.7,
 "gust_kph": 31.7
 */
