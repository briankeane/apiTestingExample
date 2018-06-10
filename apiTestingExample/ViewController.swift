//
//  ViewController.swift
//  apiTestingExample
//
//  Created by Brian D Keane on 6/9/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @objc var api:API = API()
    @objc var displayHelper:DisplayHelper = DisplayHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getWeatherButtonPressed(_ sender: Any)
    {
        self.api.getWeather(cityName:self.cityTextField.text!) {
            (weatherData) -> Void in
            
            // show an alert if something went wrong
            guard weatherData != nil else {
                self.displayHelper.displayAlert(presentingVC: self, title: "Uh Oh", message: "An Unknown Error Occured While getting the Weather")
                return
            }
            
            // otherwise adjust the interface
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self.cityTextField.text = ""
                    self.descriptionLabel.text = weatherData!["description"] as! String
                    self.tempLabel.text = "\(weatherData!["temp"] as! Double) degrees"
                }
            }
        }
    }
}

