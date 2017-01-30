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
   
    //var searchParamter: SearchParameter
    
    
    var parameters = [Parameter]()
    
    var sizeLimit: String = "2"
    
    var sizeString: String {
        return "pageSize=\(sizeLimit)"
    }
    
    init() {
      // searchTerm = "zombie"
       // searchParamter = .name
        
    }
    
    init(sizeLimit: String = "50", term: String, parameters: [Parameter]) {
        searchTerm = term
       // searchParamter = parameters
        self.parameters = parameters
    }
    
//    func getSearchURL(baseURL: String) -> URL? {
//        
//        var urlString: String = ""
//        
//        
//        // TODO: url endpoints(correct term?) shouldnt be hardcoded here
//        
//        switch searchParamter {
//        case .name: urlString = baseURL + sizeString + "&name=\(searchTerm)"
//        case .color: urlString = baseURL + "&colors=\(searchTerm)"
//        case .cmc: urlString = baseURL + "&cmc=\(searchTerm)"
//        case .set:urlString = baseURL + "&set=\(searchTerm)"
//        default: urlString = ""
//        }
//        
//        
//        if let url = URL(string: urlString) {
//            return url
//        }
//        
//        print("Search getSearchURL failed")
//        return nil
//        
//    }
    
    /*
     name|name|name   = or
     "red,white,blue"  = not black, green or colorless
     not black = "red,white,green,blue,colorless"
     
     */
    
    
//    func formatValueWithLogic(values: [String], logic: LogicState) -> String {
//        
//        var formattedValue = ""
//        
//        for val in values {
//            if formattedValue == "" {
//                formattedValue += val
//            } else {
//                formattedValue += "\(logic.rawValue)\(val)"
//            }
//        }
//        
//    }

        
//        func getQueryItemsFromParameters() -> [URLQueryItem] {
//            
//            var colors = String()
//            var cmc = [String]()
//            var types = String()
//            var sets = [String]()
//            
//            for parameter in parameters {
//                
//                switch parameter.parameterType {
//                    
//                case .color:
//                    if parameter.logicState == ._is {
//                        colors += ",\(parameter.value)"
//                    } else if parameter.logicState == ._or {
//                        colors += "|\(parameter.value)"
//                    }
//                case .cmc:
//                    cmc.append(parameter.value)
//                case .type:
//                    if parameter.logicState == ._is {
//                        types += ",\(parameter.value)"
//                    } else if parameter.logicState == ._or {
//                        types += "|\(parameter.value)"
//                    }
//                case .set:
//                    sets.append(parameter.value)
//                default: print("getQueryItems FAIL")
//                    
//                    
//                }
//                
//                
//            }
//            let typesQuery = URLQueryItem(name: "types", value: types)
//            let colorsQuery = URLQueryItem(name: "colors", value: colors)
//            // let name = URLQueryItem(name: "name", value: searchTerm)
//            return [typesQuery,colorsQuery]
//        }
    
//        
//        func getURLWithComponents(queryItems: [URLQueryItem]) -> URL? {
//            var urlComponents = URLComponents()
//            urlComponents.scheme = "https"
//            urlComponents.host = "api.magicthegathering.io"
//            urlComponents.path = "/v1/cards"
//            
//            var items = queryItems
//            // let name = URLQueryItem(name: "name", value: "")
//            //  let item = URLQueryItem(name: "colors", value: "blue")
//            let item2 = URLQueryItem(name: "pageSize", value: "20")
//            // items.append(name)
//            items.append(item2)
//            //  queryItems.append(item)
//            
//            urlComponents.queryItems = items
//            
//            print(urlComponents.url)
//            
//            return urlComponents.url
//        }
    
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
            
            var queryItems = getQueryItemsFromParameters()
            
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.magicthegathering.io"
            urlComponents.path = "/v1/cards"
            
            if search.searchTerm != "" {
                let nameQuery = URLQueryItem(name: "name", value: search.searchTerm)
                queryItems.append(nameQuery)
            }
            
            urlComponents.queryItems = queryItems
            
            let stringWithoutBullshit = urlComponents.string!.replacingOccurrences(of: "%7C", with: "|")
            //ignore the force unwrap
            guard let encodedURL = stringWithoutBullshit.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                print("unhelpful message")
                return nil
            }
            
            //let correctURL = URL(string: encodedURL)
            
//            print"URLComponents.url:\(urlComponents.url)"
//            print"URL String: \(stringWithoutBullshit)"
//            
           
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
                
                switch parameter.parameterType {
                    
                case .color:
                    if parameter.logicState == ._is {
                        if colors.isEmpty {
                            colors += parameter.value
                        } else {
                            colors += ",\(parameter.value)"
                        }
                        
                    } else if parameter.logicState == ._or {
                        if colors.isEmpty {
                            colors += parameter.value
                        } else {
                            colors += ",\(parameter.value)"
                        }
                    }
                case .cmc:
                    cmc.append(parameter.value)
                case .type:
                    if parameter.logicState == ._is {
                        if types.isEmpty {
                            types += parameter.value
                        } else {
                            types += ",\(parameter.value)"
                        }
                        
                    } else if parameter.logicState == ._or {
                        if types.isEmpty {
                            types += parameter.value
                        } else {
                            types += ",\(parameter.value)"
                        }
                    }
                case .set:
                    if parameter.logicState == ._is {
                        if sets.isEmpty {
                            sets += parameter.value
                        } else {
                            sets += ",\(parameter.value)"
                        }
                        
                    } else if parameter.logicState == ._or {
                        if sets.isEmpty {
                            sets += parameter.value
                        } else {
                            sets += ",\(parameter.value)"
                        }
                    }
                    
                    if sets == "Standard" {
                        sets = currentStandard
                    }
                    
                default: print("getQueryItems FAIL")
                    
                    
                }
                
                
            }
        
            var items = [URLQueryItem]()
        
        
        
            let typesQuery = URLQueryItem(name: "types", value: types)
            let colorsQuery = URLQueryItem(name: "colors", value: colors)
        let setsQuery = URLQueryItem(name: "set", value: sets)
            // let name = URLQueryItem(name: "name", value: searchTerm)
        let sizeLimit = URLQueryItem(name: "pageSize", value: "12")
        
      
        
        
        
        if !types.isEmpty {
            items.append(typesQuery)
        }
        if !colors.isEmpty {
            items.append(colorsQuery)
        }
        if !sets.isEmpty {
            items.append(setsQuery)
        }
            
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





