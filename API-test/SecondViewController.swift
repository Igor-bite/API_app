//
//  SecondViewController.swift
//  API-test
//
//  Created by Игорь Клюжев on 17.04.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import UIKit

let api_key = "e13117e6-789c-4689-882f-f480dbc1418e"

class SecondViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_picture()
        request_for_spb()
        // Do any additional setup after loading the view.
    }
    
    func get_picture() {
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
        
        var errorHasOccured: Bool = false
        var temperature: Double?
        var feels_like: Double?
        var humidity: Double?
        var visibility: Double?
        var wind_speed: Double?
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                as! [String : [String : AnyObject]]
                if json.isEmpty {
                    errorHasOccured = true
                }
                
                var current = json["current"] as! [String : AnyObject]?

                temperature = current?["temp_c"] as! Double?
                humidity = current?["humidity"] as! Double?
                visibility = current?["vis_km"] as! Double?
                wind_speed = current?["wind_kph"] as! Double?
                feels_like = current?["feelslike_c"] as! Double?

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
                
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        
    }
}
