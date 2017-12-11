//
//  Util.swift
//  SleepingInTheLibrary
//
//  Created by User on 12/10/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

typealias SLDictionary = [String: AnyObject]
typealias SLArray = [SLDictionary]

class Util {
    class func escaped(parameters: [String: AnyObject]) -> String {
        guard !parameters.isEmpty else { return "" }
        
        let keyValuePairs = parameters.map({ key, value in
            return key + "=" + "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }).joined(separator: "&")
        
        
        return "?\(keyValuePairs)"
    }
    
    class func showAlert(for message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
