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
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var stupidStackView: UIStackView!
    
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

    var borderColor: UIColor = .lightGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = true
        
        setupUI()
        setupGestureRecognizer()
        
        addColoredBorder()
        
        
        setRulingsText()
        
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
        
        navigationItem.title = card?.name
        
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
    
    func configureBorder() {
        if let c = card {
            switch c.cardColor {
            case .red: borderColor = .red
            case .blue: borderColor = .blue
            case .white: borderColor = .white
            case .black: borderColor = .black
            case .green: borderColor = .green
            case .multi: borderColor = .yellow
            case .colorless: borderColor = .lightGray
            }
        }
    }
}

extension CardDetailViewController {
    
    func addColoredBorder() {
        configureBorder()
       
        let border = DetailBorder(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        border.borderColor = borderColor
        border.backgroundColor = UIColor.clear
        view.addSubview(border)

        view.insertSubview(border, belowSubview: stupidStackView)
        
    }
    
}

extension CardDetailViewController {
    
    func setRulingsText() {
        
        var text = String()
        
        var rulingsArray = [String]()
        
        var date = String()
        var rulingText = String()
        
        guard let rulings = card?.rulings else { return }
        
        for rule in rulings {
            if let _date = rule["date"] {
                date = _date
            }
            if let text = rule["text"] {
                rulingText = text
            }
            
            rulingText = "\(date): \(rulingText)"
            if rulingText == ": " {
                rulingText = "no rulings found"
            }
            rulingsArray.append(rulingText)
            
        }
        
        for ruling in rulingsArray {
            text += "\(ruling)\n"
            text += "\n"
        }
        
        textView.text = text
        
        
    }
}


















//
