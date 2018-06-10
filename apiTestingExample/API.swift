//
//  API.swift
//  apiTestingExample
//
//  Created by Brian D Keane on 6/10/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit
import Alamofire

let weatherAPIKey = "GET_THIS_FROM_https://openweathermap.org/"

class API: NSObject {
    func getWeather (cityName:String, completion: @escaping (([String:Any?]?) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(weatherAPIKey)&units=imperial"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON {
                (response) -> Void in
                if let statusCode = response.response?.statusCode {
                    if (200..<300 ~= statusCode)
                    {
                        if let weatherData = response.result.value as? [String:Any] {
                            let desriptionBlock = weatherData["weather"] as! [[String:Any]]
                            let description = desriptionBlock[0]["description"] as! String
                            let temp = (weatherData["main"] as! [String:Any])["temp"] as! Double
                            
                            return completion([
                                "temp": temp,
                                "description": description
                            ])
                        }
                    }
                }
                completion(nil)
        }
    }
}
