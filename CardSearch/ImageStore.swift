//
//  ImageStore.swift
//  CardSearch
//
//  Created by Reed Carson on 2/14/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit



class ImageStore {
    static var images = [CardImage]()
}

struct CardImage: Equatable {
   
    let image: UIImage
    
    let associatedCardID: String
    
    static func ==(lhs: CardImage, rhs: CardImage) -> Bool {
        return lhs.associatedCardID == rhs.associatedCardID
    }
   

}
