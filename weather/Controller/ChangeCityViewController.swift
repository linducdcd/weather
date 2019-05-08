//
//  ChangeCityViewController.swift
//  weather
//
//  Created by Lind Ucdcd on 5/2/19.
//  Copyright © 2019 Lind Ucdcd. All rights reserved.
//

import UIKit

//Write protocol Declaration
protocol changeCityDelegate {
    func userEnteredANewCity(city: String)
}

class ChangeCityViewController: UIViewController {
   
    var delegate: changeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func backButtom(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        
        
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredANewCity(city: cityName)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
