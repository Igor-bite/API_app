//
//  Notifications.swift
//  API-test
//
//  Created by Игорь Клюжев on 03.06.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

let notificationCenter = UNUserNotificationCenter.current()

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granted, error) in
            
            guard granted else { return }
            notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
//        notificationCenter.delegate = self
//        sendNotification()
        return true
    }
    
    func sendNotification() {
        
        let content  = UNMutableNotificationContent()
        content.title = "First notification"
        content.body = "My first notification"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("opened notif")
    }
}


