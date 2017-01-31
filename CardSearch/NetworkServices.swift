//
//  NetworkServices.swift
//  CardSearch
//
//  Created by Reed Carson on 1/21/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


struct MTGAPIService {
    
    func performSearch(url: URL, completion: @escaping ([String:Any]) -> Void) {

      let  networkOperation = NetworkOperation(url: url)

        networkOperation.retrieveJSON {
            json in
            if let data = json {
                completion(data)
            }
            
            print("\nMTGAPIService performSearch - json results: \(json != nil ? "Success" : "fail")")
        }
        
    }

}



class NetworkOperation {
    
    typealias JSONCompletion = ([String:Any]?) -> Void
    
    var session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
    
    let queryURL: URL
    
    init(url: URL) {
        self.queryURL = url
    }
    
    func retrieveJSON(completion: @escaping ([String:Any]?) -> Void) {
        
        print("NetworkOperation: running retrieveJSON")
       
        let request = URLRequest(url: queryURL)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("NetworkOperation retrieveJSON error: \(error)")
                return
            }
            
            if let HTTPResponse = response as? HTTPURLResponse {
                switch HTTPResponse.statusCode {
                case 200:
                    print("HTTP Response: 200 Success")
                    
                    let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                    
                    completion(json!)
                    
                case 400...499: print("HTTP Response: 400+ client error")
                case 500...599: print("HTTP Response: 500+ server error")
                    
                default: print("HTTP Response: Some Error")
                    
                }
                
            } else { print("invalid http response")
                
            }
            
        }
        
        dataTask.resume()
        
    }
    
}


