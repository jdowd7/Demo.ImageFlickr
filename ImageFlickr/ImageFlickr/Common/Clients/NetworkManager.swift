//
//  NetworkRestClient.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 3/31/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    // MARK: Properties
    var urlRequest: URLRequest
    
    // MARK: Constructor
    init(url: URL, httpMethod: String, params: Dictionary<String, String>?, headers: Dictionary<String, String>?) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params ?? Dictionary<String, String>(), options: [])
        for (key, value) in headers! {
            urlRequest.addValue(key, forHTTPHeaderField: value)
        }
    }
    
    // MARK: Instance Methods
    func executeJsonRequest(finished: @escaping (_ json: [String: Any]) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("httpResponse error: @%", error.unsafelyUnwrapped)
                return
            }
            do {
                if httpResponse.statusCode != 200 {
                    print("Request Failed: @%", error.unsafelyUnwrapped)
                }
                
                guard let jsonDic = try JSONSerialization.jsonObject(with: data!)
                    as? [String: Any] else {
                        print("json parse error: @%", error.unsafelyUnwrapped)
                        return
                }
                finished(jsonDic)
            } catch {
                print("error on rest call: @%", error)
            }
        })
        task.resume()
    }
    

    

}


