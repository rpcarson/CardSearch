//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


let dummyData = false

private let reuseIdentifier = "CardCellID"


struct CardSorter {
    
    static func removeDuplicatesByName(cards:[Card])->[Card] {
        
        var uniqueNames = [String]()
        
        var uniqueCards = [Card]()
        
        for card in cards {
            
            if !uniqueNames.contains(card.name) {
                uniqueCards.append(card)
                print("uniqe card appended \(card.name)")
            }
            
            uniqueNames.append(card.name)
            
        }
        
        return uniqueCards
        
        
    }
   static func removeDuplicatesByID(cards: [Card]) -> [Card] {
        
        var uniqueIDs = [Int]()
        
        var uniqueCards = [Card]()
    
        for card in cards {
           
            if !uniqueIDs.contains(card.id) {
                uniqueCards.append(card)
                print("uniqe card appended \(card.id)")
            }
            
            uniqueIDs.append(card.id)

        }
        
        return uniqueCards
        
        
        
//        var validID = [Int]()
//        
//        var uniqueID = Set(validID)
//        
//        var filteredCardArray = [Card]()
//        
//        for card in cards {
//            validID.append(card.id)
//        }
//        
//        for id in uniqueID {
//            for card in cards {
//                if card.id == id {
//                    filteredCardArray.append(card)
//                    uniqueID.remove(id)
//                }
//            }
//            
//        }
//       return filteredCardArray
    }
}

class CardCollectionViewController: UICollectionViewController {
    
    var cardData = [Card]() 
    
    var mtgAPISerivce = MTGAPIService()
    
    
    let cardsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 40.0, left: 15.0, bottom: 40.0, right: 15.0)
    let cardSize = CGSize(width: 63, height: 88)
    var cardSizeRatio: CGFloat {
        return cardSize.height/cardSize.width
    }
    
    
    @IBAction func loadData() {
        
        if dummyData {
            for _ in 1...21 {
                cardData.append(Card())
                self.collectionView?.reloadData()
            }
        } else {
            
            mtgAPISerivce.search(searchTerm: "zombie") {
                results in
                self.cardData = CardSorter.removeDuplicatesByName(cards: results)
                
                DispatchQueue.main.async {
                    print("Closure called in func loadData")
                    self.collectionView?.reloadData()
                }
            }
            
        }
        
      
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cardData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        
        let card = cardData[indexPath.row]

        cell.cardData = card
        
        if dummyData {
            cell.cardNameLabel.text = String(describing: indexPath.row)
            cell.backgroundColor = UIColor.gray
            
            
            return cell
        }
        
        cell.cardNameLabel.text = cell.cardData.name
        
        
        if let image = JSONParser.parser.getImage(imageURL: cell.cardData.imageURL) {
             cell.cardImageView.image = image
            
        } else {
            print("getting card image failed at cell creation")
        }
      
        print("Cell Created, imageURL = \(cell.cardData.imageURL)")
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (cardsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / cardsPerRow
        let height = widthPerItem * cardSizeRatio
        
        return CGSize(width: widthPerItem, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}









//
