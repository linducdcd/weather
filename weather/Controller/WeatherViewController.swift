//
//  ViewController.swift
//  weather
//
//  Created by Lind Ucdcd on 5/2/19.
//  Copyright © 2019 Lind Ucdcd. All rights reserved.
//

import UIKit
import CoreLocation


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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

