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


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Constant
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "90a5849f06a81d362534fa5f3f06fc87"
    
    
    let locationManager = CLLocationManager()
    
    
    
    @IBOutlet weak var temperatureLabal: UILabel!
    @IBOutlet weak var cityLabal: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set location manager here
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
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
        Alamofire.request("WEATHER_URL").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
    }
    
    
    
    
    //Write the didUpdate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]

            getWaetherData(url: WEATHER_URL, parameters: params)
            
        }
    }
    
    //Write the didFaildWithEroro metode
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabal.text = "Location Unavailable"
    }
    

}

