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
    init(url: URL, httpMethod: String, params: Dictionary<String, String>, headers: Dictionary<String, String>) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        for (key, value) in headers {
            urlRequest.addValue(key, forHTTPHeaderField: value)
        }
    }
    
    // MARK: Instance Methods
    func executeJsonRequest(finished: @escaping (_ json: PhotoModel) -> Void) {
        let task = URLSession.shared.dataTask(with: self.urlRequest) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("httpResponse error: @%", error.unsafelyUnwrapped)
                return
            }

            if httpResponse.statusCode != 200 {
                print("Request Failed: @%", error.unsafelyUnwrapped)
            }
        
            guard let responseData = data else {
                print("error: no data")
                return
            }

        
            let jsonDecoder = JSONDecoder()
            do {
                    let jsonDic = try jsonDecoder.decode(PhotoModel.self, from: responseData)
                
                    finished(jsonDic)
						} catch let error {
							if let dError = error as? DecodingError {
								switch dError {
								case .typeMismatch(let key, let value):
									print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
								case .valueNotFound(let key, let value):
									print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
								case .keyNotFound(let key, let value):
									print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
								case .dataCorrupted(let key):
									print("error \(key), and ERROR: \(error.localizedDescription)")
								default:
									print("ERROR: \(error.localizedDescription)")
								}
							}
							print("Error on decoder")
						}
        }
							 
        task.resume()
    }
    

    

}


