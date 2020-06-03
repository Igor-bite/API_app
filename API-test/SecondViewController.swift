//
//  SecondViewController.swift
//  API-test
//
//  Created by Игорь Клюжев on 17.04.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

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
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Назначение делегата для менеджера
        manager.delegate = self
        //Начало обновления позиции
        manager.startUpdatingLocation()
        
        view.backgroundColor = .white
        
        self.temp.isHidden = true
        self.feels_like.isHidden = true
        self.describe.isHidden = true
        self.humidity_label.isHidden = true
        self.wind_label.isHidden = true
        self.visibility_label.isHidden = true
//        DispatchQueue.global(qos: .background).async {
        self.get_background()
//        }
        
        self.adviceLabel.text = ""
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
// MARK: -Location

let manager: CLLocationManager = {
    let locationManager = CLLocationManager()

    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    //Точность измерения самой системой - чем она лучше, тем больше энергии потребляеет приложение. Задаётся через набор k-констант. Старайтесь использовать ту точность, что реально важна для приложения
    locationManager.distanceFilter = 10
    //Свойство отвечает за фильтр дистанции - величину, лишь при изменении на которую будет срабатывать изменение локации

//    locationManager.pausesLocationUpdatesAutomatically = true
    //Позволяет системе автоматически останавливать обновление локации для балансировщика энергии
    locationManager.activityType = .fitness
    //Через это свойство Вы можете указать тип действий, для которого используется геопозиция, это позволит системе лучше обрабатывать балансировку геопозиции
    locationManager.showsBackgroundLocationIndicator = true
    //С помощью этого свойства мы решаем, показывать или нет значок геопозиции для работы в фоновом режиме
    return locationManager
}()
