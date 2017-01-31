//
//  SearchCollectionViewDatasource.swift
//  CardSearch
//
//  Created by Reed Carson on 1/30/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class SearchCollectionViewDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    var cells = [CardCell]()
    
    
    let cardsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let cardSize = CGSize(width: 63, height: 88)
    var cardSizeRatio: CGFloat {
        return cardSize.height/cardSize.width
    }
    
    
    
    var cardManager: CardManager = CardManager()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardManager.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        
        let index = indexPath.row
        
        let card = cardManager.cards[index]
        
        if cell.isNew {
            cell.cardData = card   // <---- keeps cards from  losing/getting data mixed up
        }
        
        
        if useDummyData {
            cell.cardNameLabel.text = String(describing: indexPath.row)
            cell.backgroundColor = UIColor.gray
            return cell
        }
        
        if !useImages {
            cell.cardNameLabel.text = "# \(indexPath.row), \(card.name)"
            cell.backgroundColor = UIColor.gray
            return cell
        }
        
        cell.cardNameLabel.isHidden = true
        
        //cells.append(cell)
        cell.backgroundColor = UIColor.lightGray
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print("will display")
        
        guard useImages else { return }
        
        if (cell as! CardCell).cardImageView.image != nil { print("image was already set")
            return
        }
        
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        cell.addSubview(indicator)
        indicator.frame = cell.bounds
        indicator.startAnimating()
        
        let card = cardManager.cards[indexPath.row]
        
        DispatchQueue.global(qos: .background).async {
            print("willDisplayCell background queue")
            
            guard let image = JSONParser.parser.getImageNoQueue(imageURL: card.imageURL) else {
                print("CCVC:willDisplayCell  - no card image retrieved")
                // TODO - display question mark
                return
            }
            
            DispatchQueue.main.async {
                
                (cell as! CardCell).setImage(image: image, andDisplay: true) {
                    
                    print("willDisplayCell main queue")
                    
                    indicator.stopAnimating()
                    
                    cell.setNeedsLayout()
                }
            }
        }
        
        print("CCVC willDisplayCell  card.image set")
        
    }
}







//
