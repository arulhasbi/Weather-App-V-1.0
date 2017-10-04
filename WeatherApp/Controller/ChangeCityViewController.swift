//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Arul on 9/26/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?

    @IBOutlet weak var textFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getWeatherData(_ sender: Any) {
        
        let cityName = textFiled.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}
