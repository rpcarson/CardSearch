//
//  NetworkServices.swift
//  CardSearch
//
//  Created by Reed Carson on 1/21/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


let testURL = URL(string: "https://api.magicthegathering.io/v1/cards?pageSize=20&subtypes=warrior&set=KTK&text=warrior")



struct MTGAPIService {
    
    
    func downloadSetsData(completion: @escaping (JSONResults) -> Void) {
        
        guard let url = URL(string: "https://api.magicthegathering.io/v1/sets") else {
            print("MTGAPIService:downloadSetsData - url failed")
            return
        }
        
        let networkOperation = NetworkOperation(url: url)
        
        networkOperation.retrieveJSON { (results) in
            if let sets = results {
                print("MTGAPIService:downloadSetsData - operation success")
                completion(sets)
            }
        }
        
    }
    
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
                case 503: print("HTTP Resonse: 503 server offline")
                case 500: print("HTTP Response: 500 server error")
                    
                default: print("HTTP Response: Some Error")
                    
                }
                
            } else { print("invalid http response")
                
            }
            
        }
        
        dataTask.resume()
        
    }
    
}


