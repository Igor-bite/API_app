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
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let urlString = "https://www.metaweather.com/api//location/search/?query=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        
         
//        var locationName: String?
        var locationID: Int?
//        var temperature: Double?
        var errorHasOccured: Bool = false
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String : AnyObject]]
                
//                if let _ = json["error"] {
//                    errorHasOccured = true
//                }
                
                locationID = json[0]["woeid"] as! Int?
                
                DispatchQueue.main.async {
                    if errorHasOccured{
                        self?.cityLabel.text = "Error has occured"
                        self?.tempLabel.isHidden = true
                    } else {
                        self?.cityLabel.text = "\(locationID!)"
                        self?.tempLabel.text = "nope"//"\(temperature!)"
                        self?.tempLabel.isHidden = false
                    }
                }
                
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
}
