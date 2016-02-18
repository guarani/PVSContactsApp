//
//  Utils.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

typealias PVSDictionary = [String: AnyObject]
typealias PVSArray = [PVSDictionary]

class Utils: NSObject {
    class func showMessage(message: String, inViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }

}

extension UIView {

}
