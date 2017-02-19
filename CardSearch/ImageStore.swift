//
//  ImageStore.swift
//  CardSearch
//
//  Created by Reed Carson on 2/14/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit



final class ImageStore {
    static var images = [CardImage]()
    
    static func addToStoreIgnoringDuplicates(_ cardImage: CardImage) {
        if !images.contains(cardImage) {
            print("ImageStore image appended")
            images.append(cardImage)
        }
    }
   
}

struct CardImage: Equatable {
    
   static var placeholder: UIImage = {
        if let img = UIImage(named: "Magic_card_back") {
            return img
        } else {
            return UIImage()
        }
    }()
   
    let image: UIImage
    
    let associatedCardID: String
    
    static func ==(lhs: CardImage, rhs: CardImage) -> Bool {
        return lhs.associatedCardID == rhs.associatedCardID
    }
    
    init(image: UIImage, cardID: String) {
        print("CardImage Init")
        self.image = image
        self.associatedCardID = cardID
        
        ImageStore.addToStoreIgnoringDuplicates(self)

    }
   

}
