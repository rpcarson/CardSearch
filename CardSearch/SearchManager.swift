//
//  SearchManager.swift
//  CardSearch
//
//  Created by Reed Carson on 1/15/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation

//TODO : - Sets need to be pulled from a database or somewhere so I dont have to update the app to accomodate new sets
enum SetCode: String {
    case DTK
    case FRF
    case KTK
    case ORI
    case BFZ
    case OGW
    case SOI
    case EMN
    case KLD
  
}



enum SearchParameter: String {
    case name
    case color
    case cmc
    case set
    case type
}




protocol SearchType {
    var searchTerm: String { get set }
    var parameters: [String:String] { get set }
}

struct Search {
    var searchTerm: String
    var searchParamter: SearchParameter
    var parameters = [Parameter]()
    var sizeLimit: String = "2"
    var sizeString: String {
        return "pageSize=\(sizeLimit)"
    }
    
    init() {
        searchTerm = "zombie"
        searchParamter = .name
       
    }
    
    init(term: String, parameters: SearchParameter) {
        searchTerm = term
        searchParamter = parameters
    }
    
    func getSearchURL(baseURL: String) -> URL? {
        
        var urlString: String = ""
        
        
        // TODO: url endpoints(correct term?) shouldnt be hardcoded here
        
        switch searchParamter {
        case .name: urlString = baseURL + sizeString + "&name=\(searchTerm)"
        case .color: urlString = baseURL + "&colors=\(searchTerm)"
        case .cmc: urlString = baseURL + "&cmc=\(searchTerm)"
        case .set:urlString = baseURL + "&set=\(searchTerm)"
        default: urlString = ""
        }
        
        
        if let url = URL(string: urlString) {
            return url
        }
        
        print("Search getSearchURL failed")
        return nil
        
    }
    
}



class SearchManager {
    
    
    var search: Search = Search()
    
    
    func configureSearch(sizeLimit: Int, searchTerm: String, parameters: [SearchParameter]) {
        
    }
    
    private func formatParameters() {
        let parameters = search.parameters
        
        var parameter = [String:[String]]()
        
        
    }
    
    func getURLWithComponents() -> NSURL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.magicthegathering.io/v1"
        urlComponents.path = "/cards"
        
        
       
        
        
        
        
        return NSURL(string: "url")
    }
    
    

    
    
}










