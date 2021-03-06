//
//  ApiKeys.swift
//  Flicks
//
//  Created by Brad B on 5/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

// Wrapper for obtaining keys from keys.plist
func valueForAPIKey(keyname:String) -> String {
    // Get the file path for keys.plist
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    
    // Put the keys in a dictionary
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    // Pull the value for the key
    let value:String = plist?.object(forKey: keyname) as! String
    
    return value
}
