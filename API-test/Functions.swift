//
//  Functions.swift
//  API-test
//
//  Created by Игорь Клюжев on 03.06.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension ViewController {
    func setupAnimation() -> Void {
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear
        
        // 2. Set animation loop mode
        
        animationView.loopMode = .loop
        
        // 3. Adjust animation speed
        
        animationView.animationSpeed = 1
        
        // 4. Play animation
        animationView.play()
        
        animationView.contentMode = .scaleAspectFit
        windAnimation.backgroundColor = .clear
        windAnimation.loopMode = .loop
        windAnimation.animationSpeed = 0.7
        windAnimation.isHidden = true
        windAnimation.play()
        waterAnimation.backgroundColor = .clear
        waterAnimation.loopMode = .loop
        waterAnimation.animationSpeed = 0.7
        waterAnimation.isHidden = true
        waterAnimation.play()
        eyeAnimation.backgroundColor = .clear
        eyeAnimation.loopMode = .loop
        eyeAnimation.animationSpeed = 0.7
        eyeAnimation.isHidden = true
        eyeAnimation.play()
    }
    
    func Display(locationName: String?, temperature: Double?,humidity: Double?,visibility: Double?,wind_speed: Double?,errorHasOccured: Bool) {
        DispatchQueue.main.async {
            if errorHasOccured{
                self.cityLabel.text = "Not found"
                self.cityLabel.isHidden = false
                self.tempLabel.isHidden = true
                self.humidityLabel.isHidden = true
                self.windSpeedLabel.isHidden = true
                self.visibilityLabel.isHidden = true
                self.animationView.isHidden = true
                self.windAnimation.isHidden = true
                self.waterAnimation.isHidden = true
                self.eyeAnimation.isHidden = true
                
            } else {
                self.animationView.isHidden = true
                self.cityLabel.text = locationName!
                self.tempLabel.text = "\(round(temperature!*10)/10) C"
                self.humidityLabel.text = "\(humidity!)%"
                self.windSpeedLabel.text = "\(round(wind_speed!*10)/10) m/s"
                self.visibilityLabel.text = "\(round(visibility!*10)/10) km"
                self.tempLabel.isHidden = false
                self.humidityLabel.isHidden = false
                self.windSpeedLabel.isHidden = false
                self.visibilityLabel.isHidden = false
                self.cityLabel.isHidden = false
                self.windAnimation.isHidden = false
                self.waterAnimation.isHidden = false
                self.eyeAnimation.isHidden = false
                UIView.animate(withDuration: 1) {
                    self.cityLabel.frame = CGRect(x: -100, y: 0, width: 100, height: 100)
                }
            }
        }
    }
}

extension SecondViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Статус авторизации
        switch status {
        //Если он не определён (то есть ни одного запроса на авторизацию не было, то попросим базовую авторизацию)
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        //Если она ограничена или запрещена, то уведомим об отключении
        case .restricted, .denied:
            print("Отключаем локацию")
        //Если авторизация базовая, то попросим предоставить полную
        case .authorizedWhenInUse:
            print("Включаем базовые функции")
            manager.requestAlwaysAuthorization()
        //Хи-хи
        case .authorizedAlways:
            print("Теперь мы знаем, где вы")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            let altitude = location.altitude
            NSLog("Высота над уровнем моря: \(altitude)\n")
            let coordinate = location.coordinate
            NSLog("Широта \(coordinate.latitude), долгота \(coordinate.longitude)\n")
            let floor = location.floor
            NSLog("Этаж \(floor?.level)\n")
            let speed = location.speed
            NSLog("Скорость \(speed)\n")
            let course = location.course
            NSLog("Азимут \(course)\n")
            let horizontalAccuracy = location.horizontalAccuracy
            let verticalAccuracy = location.verticalAccuracy
            NSLog("Точность: (\(horizontalAccuracy), \(verticalAccuracy))\n")
            let timestamp = location.timestamp
            NSLog("Временная метка \(timestamp)\n")
            request_for_current(longtitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Если ошибку можно превратить в ошибку геопоозии, то сделаем это
        guard let locationError = error as? CLError else {
            //Иначе выведем как есть
            print(error)
            return
        }

        //Если получилось, то можно получить локализованное описание ошибки
        NSLog(locationError.localizedDescription)
    }
}
