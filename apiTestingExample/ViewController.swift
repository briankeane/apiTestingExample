//
//  ViewController.swift
//  apiTestingExample
//
//  Created by Brian D Keane on 6/9/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit
import Alamofire

let weatherAPIKey = "GET_THIS_FROM_https://openweathermap.org/"

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getWeather (completion: @escaping (([String:Any?]?) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(self.cityTextField.text!)&appid=\(weatherAPIKey)&units=imperial"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON {
                (response) -> Void in
                if let statusCode = response.response?.statusCode {
                    if (200..<300 ~= statusCode)
                    {
                        if let weatherData = response.result.value as? [String:Any] {
                           return completion(weatherData)
                        }
                    }
                }
                completion(nil)
        }
    }
    @IBAction func getWeatherButtonPressed(_ sender: Any)
    {
        self.getWeather(){
            (weatherData) -> Void in
            
            // show an alert if something went wrong
            guard weatherData != nil else {
                let alert = UIAlertController(title: "Uh Oh", message: "An Unknown Error Occured While getting the Weather", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) -> Void in }
                ))
                self.present(alert, animated: true)
                return
            }
            
            // otherwise adjust the interface
            let desriptionBlock = weatherData!["weather"] as! [[String:Any]]
            let description = desriptionBlock[0]["description"] as! String
            let temp = (weatherData!["main"] as! [String:Any])["temp"] as! Double
            
            DispatchQueue.main.async {
                self.cityTextField.text = ""
                self.descriptionLabel.text = description
                self.tempLabel.text = "\(temp) degrees"
            }
        }
    }
}

