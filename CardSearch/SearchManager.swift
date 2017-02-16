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
    case AER
    
}

enum StandardSets: String {
    case BFZ
    case OGW
    case SOI
    case EMN
    case KLD
    case AER
}

let currentStandard = "BFZ|OGW|SOI|EMN|KLD|AER"



enum SearchParameter: String {
    case name
    case color
    case cmc
    case set
    case type
}

struct Search {
    
    var searchTerm: String = ""
    
    var parameters = [Parameter]()
    
    var sizeLimit: String = "\(testingPageSize)"
    
    init() {
    }
    
    init(sizeLimit: String = "50", term: String, parameters: [Parameter]) {
        searchTerm = term
        self.parameters = parameters
    }
}



class SearchManager {
    
    
    var search: Search = Search()
    
    func updateParameters(parameters: [Parameter]) {
        search.parameters = parameters
    }
    
    func updateSearchTerm(term: String?) {
        
        search.searchTerm = (term != nil ? term! : "")
    }
    
    
    func configureSearch(sizeLimit: String = "12", searchTerm: String, parameters: [Parameter] = [Parameter]()) {
        search.parameters = parameters
        search.searchTerm = searchTerm
        search.sizeLimit = sizeLimit
        
    }
    
    func constructURLWithComponents() -> URL? {
        
        let queryItems = getQueryItemsFromParameters()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.magicthegathering.io"
        urlComponents.path = "/v1/cards"
        urlComponents.queryItems = queryItems
        
        var stringWithoutBullshit = urlComponents.string!.replacingOccurrences(of: "%7C", with: "|")
        stringWithoutBullshit = stringWithoutBullshit.replacingOccurrences(of: "%20", with: " ")
        
        guard let encodedURL = stringWithoutBullshit.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            print("constructURLWithComponents - addingPercentEncoding fail")
            return nil
        }
        
        
        print("URLComponents.url:\(urlComponents.url)")
        print("URL String: \(encodedURL)")
        
        let uRaEl = URL(string: encodedURL)
        print("URAEL: \(uRaEl)")
        return uRaEl
    }
    


    private func getQueryItemsFromParameters() -> [URLQueryItem] {
        
        var colors = String()
        var cmc = [String]()
        var types = String()
        var sets = String()
        
        for parameter in search.parameters {
            
            var seperator: String {
                switch parameter.logicState {
                case ._is: return ","
                case ._or: return "/"
                case ._not: return "notsure yet"
                }
            }
            
            var valueString = "\(parameter.value)"
            
            switch parameter.parameterType {
                
            case .color:
                if !colors.isEmpty {
                    valueString = "\(parameter.logicState.rawValue)\(parameter.value)"
                }
                colors += valueString
       
            case .cmc:
                cmc.append(parameter.value)
                
            case .type:
                if !types.isEmpty {
                    valueString = "\(parameter.logicState.rawValue)\(parameter.value)"
                }
                types += valueString
       
            case .set:
                if !sets.isEmpty {
                    valueString = "\(parameter.logicState.rawValue)\(parameter.value)"
                }
                sets += valueString
            default: print("getQueryItems FAIL")
            }
        }
        
        var items = [URLQueryItem]()
        
        let typesQuery = URLQueryItem(name: "types", value: types)
        let colorsQuery = URLQueryItem(name: "colors", value: colors)
        let setsQuery = URLQueryItem(name: "set", value: sets)
        let sizeLimit = URLQueryItem(name: "pageSize", value: search.sizeLimit)
        
        let nameQuery = URLQueryItem(name: "name", value: search.searchTerm)
        
        
        if !types.isEmpty {
            items.append(typesQuery)
        }
        if !colors.isEmpty {
            items.append(colorsQuery)
        }
        if !sets.isEmpty {
            items.append(setsQuery)
        }
        if !search.searchTerm.isEmpty {
            items.append(nameQuery)
        }
        if Int(search.sizeLimit)! > 100 {
            let pageQuery = URLQueryItem(name: "page", value: "2")
            items.append(pageQuery)
        }
        
        items.append(sizeLimit)
        
        return items
        
        
    }
    
    
    
}

extension CharacterSet {
    static let urlQueryAllowedChar: CharacterSet = {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove("|")
        return allowed
    }()
    
    static func urlQueryValueAllowed() -> CharacterSet {
        return CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~/?|=")
    }
}

extension String {
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet.urlQueryValueAllowed()
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}





