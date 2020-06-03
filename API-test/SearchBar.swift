//
//  SearchBar.swift
//  API-test
//
//  Created by Игорь Клюжев on 03.06.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animationView.isHidden = false
        self.windAnimation.isHidden = true
        self.waterAnimation.isHidden = true
        self.eyeAnimation.isHidden = true
        self.cityLabel.isHidden = true
        self.tempLabel.isHidden = true
        self.humidityLabel.isHidden = true
        self.windSpeedLabel.isHidden = true
        self.visibilityLabel.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        segmentTemp.selectedSegmentIndex = 1
        
        self.parse_ID(ind: 1)
    }
}
