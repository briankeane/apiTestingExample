//
//  DisplayHelper.swift
//  apiTestingExample
//
//  Created by Brian D Keane on 6/10/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit

class DisplayHelper: NSObject {
    func displayAlert(presentingVC:UIViewController, title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) -> Void in }
        ))
        presentingVC.present(alert, animated: true)
    }
}
