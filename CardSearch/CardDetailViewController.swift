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

private var greyStar: UIImage = {
    return UIImage(named: "66x66gray.png")!
}()

private var goldStar: UIImage = {
    return UIImage(named: "66x66gold.png")!
}()


class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var cardView: UIImageView!
    
    let storyboardID = "cardDetailControllerID"
    
    var swipeRecognizer = UISwipeGestureRecognizer()
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    let favoritesButton: UIButton = UIButton(type: .custom)
    
    var barButton: UIBarButtonItem {
        return UIBarButtonItem(customView: favoritesButton)
    }
    
    var isInCollection: Bool = false
    
    var image: UIImage? {
        didSet {
            print("image set")
        }
    }
    
    var card: Card?
    
    func swipeToDismiss() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func addToDefaultCollection() {
       // if isInCollection { print("already in collection") ; return }
        
        guard let card = self.card else {
            print("CDVC: addToCollection - no card")
            return
        }
        
        CollectionsManager.sharedManager.addCardToCollection(card: card, collection: "Favorites")
        
        isInCollection = true
        
        toggleStar()
        
        print("added to collection")
        
    }
    
    func removeCardFromCollection() {
       // if !isInCollection { print("card not in llection - this sholdnt be called") ; return }
        
        guard let card = self.card else {
            print("CDVC: addToCollection - no card")
            return
        }
        
        CollectionsManager.sharedManager.removeFromCollection(card: card)
        
        isInCollection = false
        
        toggleStar()
        
        print("removed from collection")
        
    }
    
    func pressStarButton() {
        if isInCollection {
            removeCardFromCollection()
        } else {
            addToDefaultCollection()
        }
    }
    
    func toggleStar() {
        if isInCollection {
            favoritesButton.setImage(goldStar, for: .normal)
           // favoritesButton.isUserInteractionEnabled = false
        } else {
            favoritesButton.setImage(greyStar, for: .normal)
           // favoritesButton.isUserInteractionEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _ = checkIfInCollection()
        toggleStar()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestureRecognizer()
        
    }
}

extension CardDetailViewController {
    func checkIfInCollection() -> Bool {
        let cards = CollectionsManager.sharedManager.collections[0].cards
        for c in cards {
            if c.id == card?.id {
                isInCollection = true
                return true
            }
        }
        isInCollection = false
        return false
    }
}


//MARK: - Setup
extension CardDetailViewController {
    
    func setupUI() {
        nameLabel.text = card?.name
        typeLabel.text = card?.type
        setLabel.text = card?.set
        cardView.image = image
        
        setupFavoritesButton()
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    func setupGestureRecognizer() {
        swipeRecognizer.addTarget(self, action: #selector(CardDetailViewController.swipeToDismiss))
        swipeRecognizer.direction = [.left,.right]
        cardView.addGestureRecognizer(swipeRecognizer)
        cardView.isUserInteractionEnabled = true
    }
    
    func setupFavoritesButton() {
        favoritesButton.setImage(greyStar, for: .normal)
        favoritesButton.addTarget(self, action: #selector(CardDetailViewController.pressStarButton), for: .touchUpInside)
        favoritesButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    }
}

















//
