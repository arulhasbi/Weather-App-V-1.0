//
//  ViewController.swift
//  WeatherApp
//
//  Created by Arul on 9/26/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON
import ProgressHUD

class ViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //MARK: - UI Element
    /***************************************************************/
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - Declare API Components
    /***************************************************************/
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "74cfd2095e4bc3998585c0947a781839"
    
    //MARK: - Declare Object
    /***************************************************************/
    
    let locationManager = CLLocationManager()
    let dataModel = WeatherDataModel()

    //MARK: - First Loading View
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - locationManagerDelegate Function didUpdateLocation
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            let params : [String: String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherUpdate(url: WEATHER_URL, parameters: params)
        } else {
            print("Location Unavailable")
        }
    }
    
    //MARK: - locationManagerDelegate Function didFailWithError
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Connection Issues"
        print(error)
    }
    
    //MARK: - Get Access HTTP Request To API Website Using Alamofire and Get Response in JSON Format
    /***************************************************************/
    
    func getWeatherUpdate(url: String, parameters: [String : String] ) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess  {
                print("URL Succed")
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                print("Current Weather")
                print("--------------------------")
                print(weatherJSON)
            } else if response.result.isFailure {
                print("Connection Issues")
            }
        }
    }
    
    //MARK: - JSON Parsing With SwiftyJSON
    /***************************************************************/
    
    func updateWeatherData(json: JSON) {
        if let temperatureResult = json["main"]["temp"].double {
            dataModel.city = json["name"].stringValue
            dataModel.temperature = "\(Int(temperatureResult - 273.15))°"
            dataModel.weatherIcon = dataModel.getWeatherIcon(collection: json["weather"][0]["id"].intValue)
            updateUI()
        }
        else {
            let alert = UIAlertController(title: "Attention", message: "We're sorry, your city is unavailable", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel)
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Update UI With The Latest WeatherDatamodel Object Data
    /***************************************************************/
    
    func updateUI() {
        cityLabel.text = dataModel.city!
        temperatureLabel.text = dataModel.temperature!
        imageStatus.image = UIImage(named: dataModel.weatherIcon!)
        if let checkDay = dataModel.getDate {
            dataModel.day = dataModel.getForecastDate(dates: checkDay)
            dataModel.month = dataModel.getForecastMonth(month: checkDay)
            dataModel.year = dataModel.getForecastYear(year: checkDay)
            dateLabel.text = "\(dataModel.day!) \(dataModel.month!) \(dataModel.year!)"
        }
    }
    
    //MARK: - Change City Delegate Protocol
    /***************************************************************/
    
    func userEnteredANewCityName(city: String) {
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherUpdate(url: WEATHER_URL, parameters: params)
    }
    
    //MARK: - Prepare For Segue Method View Controller
    /***************************************************************/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChangeCityScreen" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

