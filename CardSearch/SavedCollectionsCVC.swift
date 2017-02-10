//
//  SavedCollectionsCVC.swift
//  CardSearch
//
//  Created by Reed Carson on 2/2/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

private let savedCollectionsCVCellReuse = "savedCollectionsCVCellID"



class SavedCVDataSource: NSObject, UICollectionViewDataSource {
    
    var collection: CardCollection?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let cards = collection?.getCards() else {
            return 0
        }
        
        guard cards.count >= 1 else {
            print("SavedVCDataSource:numberofitems - no cards")
            return 0
        }
        
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: savedCollectionsCVCellReuse, for: indexPath) as! SavedCollectionsCVCell
        
        cell.backgroundColor = UIColor.lightGray
        
        cell.nameLabel.text = String(indexPath.row)
        
        return cell
    }
    
}

class SavedCollectionsCVC: UICollectionViewController {
    
    let dataSource = SavedCVDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        dataSource.collection = CollectionsManager.sharedManager.collections[0]
        
        collectionView?.reloadData()
        
        print("view will apeepee called")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        collectionView?.dataSource = dataSource
               
        dataSource.collection = CollectionsManager.sharedManager.collections[0]
        
        print("loaded collectors view")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
