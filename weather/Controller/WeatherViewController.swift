//
//  ViewController.swift
//  weather
//
//  Created by Lind Ucdcd on 5/2/19.
//  Copyright © 2019 Lind Ucdcd. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate, changeCityDelegate {
    
    //MARK: - Constant
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "90a5849f06a81d362534fa5f3f06fc87"
    
    //TODO: Declaree instance constantes
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    //TODO: segue data
    var nameCity : String = ""
    
    @IBOutlet weak var temperatureLabal: UILabel!
    @IBOutlet weak var cityLabal: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBAction func switchToCityView(_ sender: Any) {
        performSegue(withIdentifier: "changCityName", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set location manager here
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Network
    
    //Write getWaetherData
    func getWaetherData(url: String, parameters: [String : String]) {
        //MARK: - Using Alamofare
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
           
            if response.result.isSuccess {
                print("Success! Got the weather data")
                
                
                
            let weatherJason = JSON(response.result.value!)
                
                print(weatherJason)
                
                self.updateWeatherData(jason: weatherJason)
                self.updateUIWeatherData()
                
                
                
            } else {
                
                print("Error \(String(describing: response.result.error))")
                
                self.cityLabal.text = "Connection Issues"
            }
            
            
            
        }
        
    }
    
    //write updateWeatherData function
    func updateWeatherData (jason : JSON) {
        if   let tempResult = jason ["main"]["temp"].double{
        weatherDataModel.temperature = tempResult - 273.15
        
        weatherDataModel.city = jason["name"].stringValue
        
        weatherDataModel.condition = jason["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        } else {
            cityLabal.text = "weather Unavalable"
            
        }
    }
    
    
    //MARK: - UI Update
    
    //Write The updateUIWithWeatherData method:
    
    func updateUIWeatherData() {
        cityLabal.text = weatherDataModel.city
        temperatureLabal.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    //Write the didUpdate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]

            getWaetherData(url: WEATHER_URL, parameters: params)
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            

        }
    }
    
    //Write the didFaildWithError metode
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabal.text = "Location Unavailable"
    }
    //MARK: - change city delegate method
    
    func userEnteredANewCity(city: String) {
        print(city)
        let params : [String:String] = ["q" : city , "appid" : APP_ID]
        
        getWaetherData(url: WEATHER_URL, parameters: params)
    }

    //Write the prepareForSegue Methode
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changCityName" {
            
           let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
}

