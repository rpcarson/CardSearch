//
//  CardDetailViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/16/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

let cardDetailVCID = "cardDetailControllerID"


let cardSize = CGSize(width: 63, height: 88)
var cardSizeRatio: CGFloat {
    return cardSize.height/cardSize.width
}



class CardDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var setLabel: UILabel!
    
    let storyboardID = "cardDetailControllerID"
    
    var swipeRecognizer = UISwipeGestureRecognizer()
    
    @IBOutlet weak var cardView: UIImageView!
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var image: UIImage? {
        didSet {
            print("image set")
        }
    }
    
    var card: Card?
    
    func swipeToDismiss() {
        print("swipe detected")
      //  cardView.removeGestureRecognizer(swipeRecognizer)
       _ = navigationController?.popViewController(animated: true)
       // dismiss(animated: true, completion: nil)
    }
    
    func setupGestureRecognizer() {
        swipeRecognizer.addTarget(self, action: #selector(CardDetailViewController.swipeToDismiss))
        swipeRecognizer.direction = [.left,.right]
        cardView.addGestureRecognizer(swipeRecognizer)
        cardView.isUserInteractionEnabled = true
    }
    
    func addToDefaultCollection() {
        
        guard let card = self.card else {
            print("CDVC: addToCollection - no card")
            return
        }
    
        RealmManager.sharedManager.saveCardAsModel(card: card, inCollection: "Favorites")
        RealmManager.sharedManager.saveCardModels()
    
        CollectionsManager.sharedManager.addCardToCollection(card: card, collection: "Favorites")
    }
    
    func setupLabels() {
        nameLabel.text = card?.name
        typeLabel.text = card?.type
        setLabel.text = card?.set
        
        cardView.image = image

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CardDetailViewController.addToDefaultCollection))
        
        navigationItem.rightBarButtonItem = barButtonAdd
        
      //  cardView.frame.width = cardView.frame.width/cardSizeRatio
        
        
        setupLabels()
        
        setupGestureRecognizer()

        
        print("card detail viewloaded")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
