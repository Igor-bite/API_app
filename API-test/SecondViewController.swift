//
//  SecondViewController.swift
//  API-test
//
//  Created by Игорь Клюжев on 17.04.2020.
//  Copyright © 2020 Игорь Клюжев. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        get_picture()
        // Do any additional setup after loading the view.
    }
    
    func get_picture() {
        let urlString = "https://picsum.photos/1080/1920"
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
