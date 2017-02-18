//
//  SearchCollectionViewDatasource.swift
//  CardSearch
//
//  Created by Reed Carson on 1/30/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class SearchCollectionViewDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let reuseIdentifier = "CardCellID"
    
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        
        let card = cardManager.cards[indexPath.row]
        
        cell.cardImageView.image = nil
        cell.cardData = card
        

        if let img = card.image {
            cell.setImage(image: img, andDisplay: true, completion: nil)
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
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard useImages else { return }
        
        let cardCell = (cell as! CardCell)
        
        let card = cardManager.cards[indexPath.row]

        
        if let img = card.image {
            cardCell.setImage(image: img, andDisplay: true) {
                print("already has image - returning from func")
                return
            }
        }
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        cell.addSubview(indicator)
        indicator.frame = cell.bounds
        indicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            JSONParser.parser.createCardImageFor(card) {
                cardImage in
                DispatchQueue.main.async {
                    guard let img = card.image else { print("guard return") ; return }
                    cardCell.setImage(image: img, andDisplay: true) {
                        indicator.stopAnimating()
                        print("willDisplayItem \(card.name): image has been set")
                    }
               
                }
           
            }

        }
        
    }
    
}







//
