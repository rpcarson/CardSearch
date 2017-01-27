//
//  CardCell.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    var cardImage: UIImage? {
        if let image = JSONParser.parser.getImage(imageURL: cardData.imageURL) {
            print("CardCell cardImage created")
            return image
        }
        print("CardCell cardImage creation failed")
        return nil
    }
    
    var image: UIImage?
   
   
    
    /*
     var cardImage: UIImage {
        var image: UIImage?
        var imageData: Data? {
            do {
               return try Data(contentsOf: URL(string: cardData.imageURL)!, options: [])
            } catch {
                print("invalid image URL")
                return nil
            }
        }
        if let data = imageData {
            image = UIImage(data: data)
            print("image data loaded")
        }
       
        return image!
    }
 */
    
    var cardData = Card()

}
