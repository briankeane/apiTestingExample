//
//  ViewControllerTests.swift
//  apiTestingExampleTests
//
//  Created by Brian D Keane on 6/10/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import XCTest
@testable import apiTestingExample
import Quick
import Nimble

class ViewControllerTests: QuickSpec {
    override func spec() {
        describe ("ViewController") {
            var vc:ViewController!
            var apiMock:MockAPI!
            var displayHelperMock:DisplayHelperMock!
            
            func setupViewController()
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                apiMock = MockAPI()
                displayHelperMock = DisplayHelperMock()
                vc.setValuesForKeys([
                    "api": apiMock,
                    "displayHelper": displayHelperMock
                ])
                let _ = vc.view
            }
            
            it ("responds correctly to a correct call") {
                setupViewController()
                apiMock.getWeatherResponse = ["temp": Double(200.0), "description": "damn hot"]
                vc.cityTextField.text = "Austin"
                vc.getWeatherButton.sendActions(for: .touchUpInside)
                expect(vc.tempLabel.text).toEventually(equal("200.0 degrees"))
                expect(vc.descriptionLabel.text).toEventually(equal("damn hot"))
            }
            
            it ("displays an alert when there was an error") {
                setupViewController()
                apiMock.getWeatherResponse = nil
                vc.getWeatherButton.sendActions(for: .touchUpInside)
                expect(displayHelperMock.displayAlertArgs.count).toEventually((equal(1)))
                let displayArgs = displayHelperMock.displayAlertArgs[0]
                
                expect(displayArgs["presentingVC"] as! ViewController).toEventually((equal(vc)))
                expect(displayArgs["title"] as! String).toEventually((equal("Uh Oh")))
                expect(displayArgs["message"] as! String).toEventually(equal("An Unknown Error Occured While getting the Weather"))
            }
        }
    }
}

