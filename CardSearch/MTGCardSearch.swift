//
//  MTGCardSearch.swift
//  CollectionViewsSwiftDeluxe
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


struct CardData {
    let cardJson: [String:String] = [:]
    
    var name = ""
    var color: String? = nil
}

var cardData = CardData()

  var dataArray = [CardData]()


class RestAPIManager: NSObject {
    
    let config = URLSessionConfiguration.default
    var session: URLSession {
       return URLSession(configuration: config)
    }
    let url = URL(string: "https://api.magicthegathering.io/v1/cards?pageSize=1")

    var task = URLSessionDataTask()
   
    func runTask() {
        
        task = session.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        print("JSON Call worked?")
                        //Implement your logic
                        print(json)
                        
                        if let cards = json["cards"] as? [[String:Any]] {
                            print("Cards")
                            for card in cards {
                                
                                var magicCard = CardData()
                                
                                if let name = card["name"] as? String {
                                    print("Name")
                                    magicCard.name = name
                                }
                               
                                if let colors = card["colors"] as? [String] {
                                    var array = [String]()
                                    for color in colors {
                                        array.append(color)
                                    }
                                    var colorString = ""
                                    for color in array {
                                            colorString += color
                                    }
                                    magicCard.color = colorString
                                }
                                
                                print("Card Name: \(magicCard.name)")
                                print("Card Name: \(magicCard.color != nil ? magicCard.color! : "nil")")
                                
                                dataArray.append(magicCard)
                            }
                           
                           
                        }
                        
                       
                        
                    
                    
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })

        task.resume()
    }

   
}



