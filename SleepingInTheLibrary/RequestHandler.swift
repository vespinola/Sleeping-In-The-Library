//
//  RequestHandler.swift
//  SleepingInTheLibrary
//
//  Created by User on 12/10/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class RequestHandler {
    class func doFor(_ urlString: String, in viewController: UIViewController, onCompletion: @escaping (Any) -> Void, onError: (() -> Void)? = nil ) {
        
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        var parsedData: Any!
        
        let checkForErrors: (Data?, URLResponse?, Error?) -> Bool = { data, response, error in
            
            guard error == nil else {
                Util.showAlert(for: "There was an error with your request: \(String(describing: error))", in: viewController)
                return false
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                Util.showAlert(for: "Your request returned a status code other than 2xx!", in: viewController)
                return false
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                Util.showAlert(for: "No data was returned by the request!", in: viewController)
                return false
            }
            
            do {
                parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                Util.showAlert(for: "Could not parse the data as JSON: '\(String(describing: data))'", in: viewController)
                return false
            }
            
            return true
        }
        
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            checkForErrors(data, response, error) ? onCompletion(parsedData) : onError?()
        })
        
        task.resume()
        
    }
}
