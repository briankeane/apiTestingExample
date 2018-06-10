//
//  DisplayHelperMock.swift
//  apiTestingExampleTests
//
//  Created by Brian D Keane on 6/10/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit
@testable import apiTestingExample

class DisplayHelperMock: DisplayHelper {
    var displayAlertArgs:[[String:Any]] = Array()
    override func displayAlert(presentingVC: UIViewController, title: String, message: String) {
        displayAlertArgs.append(["presentingVC": presentingVC,
                                 "title": title,
                                 "message": message
        ])
    }
}
