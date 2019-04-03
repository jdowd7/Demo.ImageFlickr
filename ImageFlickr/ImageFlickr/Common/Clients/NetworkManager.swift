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
    var decoder: JSONDecoder
    
    // MARK: Constructor
    init(url: URL, httpMethod: String, params: Dictionary<String, String>, headers: Dictionary<String, String>) {
        self.decoder = JSONDecoder()
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        for (key, value) in headers {
            urlRequest.addValue(key, forHTTPHeaderField: value)
        }
    }
    
    // MARK: Instance Methods
    func executeJsonRequest(finished: @escaping (_ json: Photos) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("httpResponse error: @%", error.unsafelyUnwrapped)
                return
            }
           // do {
                if httpResponse.statusCode != 200 {
                    print("Request Failed: @%", error.unsafelyUnwrapped)
                }
            
                guard let responseData = data else {
                    print("error: no data")
                    return
                }
                /*
                 guard let jsonDic = try JSONSerialization.jsonObject(with: data!)
                    as? [String: Any] else {
                        print("json parse error: @%", error.unsafelyUnwrapped)
                        return
                }
                */
                
                guard let jsonDic = try? self.decoder.decode(Photos.self, from: responseData) else {
                        print("json parse error: @%", error.unsafelyUnwrapped)
                        return
                }
                
                finished(jsonDic)
           /* } catch {
                print("error on rest call: @%", error)
            }
 */
        })
        task.resume()
    }
    

    

}


