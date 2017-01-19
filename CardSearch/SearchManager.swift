//
//  SearchManager.swift
//  CardSearch
//
//  Created by Reed Carson on 1/15/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


enum SearchParameter {
    case name
    case color
    case cmc
}


protocol SearchType {
    var searchTerm: String { get set }
    var parameters: [SearchParameter] { get set }
}

struct Search: SearchType {
    var searchTerm: String
    var searchParamter: SearchParameter
    var parameters: [SearchParameter] = [.name]
    var sizeLimit: String = "2"
    var sizeString: String {
        return "pageSize=\(sizeLimit)"
    }
    
    init() {
        searchTerm = "zombie"
        searchParamter = .name
        parameters = [.name]
    }
    
    init(term: String, parameter: SearchParameter) {
        searchTerm = term
        searchParamter = parameter
    }
    
    func getSearchURL(baseURL: String) -> URL? {
        
        var urlString: String
        
        
        // TODO: url endpoints(correct term?) shouldnt be hardcoded here
        
        switch searchParamter {
        case .name: urlString = baseURL + sizeString + "&name=\(searchTerm)"
        case .color: urlString = baseURL + "&colors=\(searchTerm)"
        case .cmc: urlString = baseURL + "&cmc=\(searchTerm)"
            
        }
        
        
        if let url = URL(string: urlString) {
            return url
        }
        
        print("Search getSearchURL failed")
        return nil
        
    }
    
}



struct SearchManager {
    
    
    var search: Search
    
    

    
    
}










