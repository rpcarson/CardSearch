//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CardCellID"

class CardCollectionViewController: UICollectionViewController {
    
    var cardData = [Card]() 
    
    var mtgAPISerivce = MTGAPIService()
    
    @IBAction func loadData() {
        mtgAPISerivce.search(searchTerm: "zombie") {
            results in
            self.cardData = results
            DispatchQueue.main.async {
                print("Closure called in func loadData")
                self.collectionView?.reloadData()
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
        
        cell.backgroundColor = UIColor.red
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
