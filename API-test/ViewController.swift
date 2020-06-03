//
//  ViewController.swift
//  API-test
//
//  Created by Игорь Клюжев on 15.04.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var segmentTemp: UISegmentedControl!
    @IBOutlet weak var picture: UIImageView!
    @IBAction func buttonclicked(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var windAnimation: AnimationView!
    @IBOutlet weak var waterAnimation: AnimationView!
    @IBOutlet weak var eyeAnimation: AnimationView!
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        
        searchBar.delegate = self
        
        segmentTemp.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        
        self.cityLabel.isHidden = true
        self.tempLabel.isHidden = true
        self.humidityLabel.isHidden = true
        self.windSpeedLabel.isHidden = true
        self.visibilityLabel.isHidden = true
        
        setupAnimation()
    }
    
    @objc func changeValue(sender:AnyObject) {
        parse_ID(ind: segmentTemp.selectedSegmentIndex)
    }
}

