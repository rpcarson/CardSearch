//
//  SavedCollectionsCVC.swift
//  CardSearch
//
//  Created by Reed Carson on 2/2/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class SavedCollectionsCVC: UICollectionViewController {
    
    let dataSource = SavedCVDataSource()
    
    let peekAndPopDelegate = PeekAndPopDelegate()
    
    override func viewWillAppear(_ animated: Bool) {
        dataSource.collection = CollectionsManager.sharedManager.collections[0]
        
        collectionView?.reloadData()
        
        print("view will apeepee called")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        peekAndPopDelegate.collectionVC = self
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: peekAndPopDelegate, sourceView: collectionView!)
        }
        
        navigationItem.title = "Favorites"
        
        collectionView?.dataSource = dataSource
               
        dataSource.collection = CollectionsManager.sharedManager.collections[0]


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetailSegue" {
            if let cardCell = sender as? CardCell {
                print("sending card data")
                let destinationController = segue.destination as! CardDetailViewController
                print("Card image \(cardCell.cardData.image)")
                print("Card name \(cardCell.cardData.name)")
                destinationController.image = cardCell.cardData.image
                destinationController.card = cardCell.cardData
                
                

                
            }
        }
        
        
    }

}





//
