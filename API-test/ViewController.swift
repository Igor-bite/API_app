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
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let apiKey = "7e5c9bf9245f103431d12d0c6cf17fa0"
        let urlString = "http://api.weatherstack.com/current?access_key=\(apiKey)&query=\(searchBar.text!)"
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperature: Double?
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            do {
                let json = try  JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                }
                
                if let current = json["current"] {
                    temperature = current["temperature"] as? Double
                }
                
            }
            catch let jsonError{ 
                print(jsonError)
            }
        }
        task.resume()
    }
}
