//
//  MockAPI.swift
//  apiTestingExampleTests
//
//  Created by Brian D Keane on 6/10/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit
@testable import apiTestingExample

class MockAPI: API {
    var getWeatherResponse:[String:Any]?
    override func getWeather(cityName: String, completion: @escaping (([String : Any?]?) -> Void)) {
        completion(self.getWeatherResponse)
    }
}
