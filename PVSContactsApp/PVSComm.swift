//
//  PVSComm.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSComm: NSObject {

    class func retrieveContacts(callback: (PVSArray -> Void)) {
        let URL = NSURL(string: "http://beta.json-generator.com/api/json/get/4yLVmeGYe")!
        let URLRequest = NSMutableURLRequest(URL: URL)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSURLSession.sharedSession().dataTaskWithRequest(URLRequest, completionHandler: { data, response, error in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            // Go back to the main thread.
            dispatch_async(dispatch_get_main_queue(), {
                if let contacts = try! NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? PVSArray {
                    callback(contacts)
                }
            })
      
            
        }).resume()
    }
}
