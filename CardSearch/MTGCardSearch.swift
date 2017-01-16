//
//  MTGCardSearch.swift
//  CollectionViewsSwiftDeluxe
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation



struct MTGAPIService {
    
    private let baseURLString = "https://api.magicthegathering.io/v1/cards?pageSize=12"
    
    func performSearch(search: Search, completion: @escaping ([Card]) -> Void) {
      
        guard let fullURL = search.getSearchURL(baseURL: baseURLString) else {
            print("MTGAPIService performSearch fullURL failed")
            return
        }
        
        let networkOperation = NetworkOperation(url: fullURL)
        
        networkOperation.retrieveJSON {
            json in
            
            if let cards = JSONParser.parser.createCard(data: json!) {
                print("MTGAPIService JSONParser created cards succesfully")
                completion(cards)
            }
            
            print("\nMTGAPI Service: running search, json results: \(json != nil ? "Success" : "fail")")
            
        }
        
    }
    
    //    private var searchParameter: SearchParameter = .name
    //
    //    private var searchTerm: String = "default"
    //
    //    private var fullURLString: String {
    //        switch searchParameter {
    //        case .name: return baseURLString + "&name=\(searchTerm)"
    //        case .color: return baseURLString + "&colors=\(searchTerm)"
    //        case .cmc: return baseURLString + "&cmc=\(searchTerm)"
    //
    //        }
    //    }
    //
    //    mutating func configSearch(parameter: SearchParameter) {
    //        self.searchParameter = parameter
    //    }
    
//    mutating func search(searchTerm: String, completion: @escaping ([Card]) -> Void) {
//        self.searchTerm = searchTerm
//        
//        if let url = URL(string: fullURLString) {
//            
//            let networkOperation = NetworkOperation(url: url)
//            
//            networkOperation.retrieveJSON {
//                json in
//                
//                if let cards = JSONParser.parser.createCard(data: json!) {
//                    print("if let cards = json MTGAPI SEARCH")
//                    completion(cards)
//                }
//               
//                print("\nMTGAPI Service: running search, json results: \(json != nil ? "Success" : "fail")")
//                
//            }
//            
//        }
//        
//        
//    }
    
    
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
    
    func retrieveJSON(completion: @escaping JSONCompletion) {
        print("NetworkOperation: running retrieveJSON")
        let request = URLRequest(url: queryURL)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
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


