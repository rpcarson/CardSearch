//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

let configSearchSegueID = "ConfigSearchSegue"

let dummyData = false

let useDebuggerCells = true

let testManager = true

let useImages = true


private let reuseIdentifier = "CardCellID"

//let testParse = true





class CardCollectionViewController: UICollectionViewController  {
    
    var cardData = [Card]()
    
    var mtgAPISerivce = MTGAPIService()
    
    var currentSearch: Search?
    
    var selectedCell: CardCell?
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    var cardManager: CardManager?
    
    
    var configVC: ConfigSearchVC?
    
    
    var resultsLimit: Int = 12
    
    var searchManager = SearchManager()
    
    
    
    @IBOutlet weak var searchField: UITextField!
    
    
    let cardsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 40.0, left: 15.0, bottom: 40.0, right: 15.0)
    let cardSize = CGSize(width: 63, height: 88)
    var cardSizeRatio: CGFloat {
        return cardSize.height/cardSize.width
    }
    
    
    @IBAction func loadData() {
        
        searchField.addSubview(activityIndicator)
        activityIndicator.frame = searchField.bounds
        activityIndicator.startAnimating()
        
        
        if dummyData {
            for _ in 1...resultsLimit {
                cardData.append(Card())
                activityIndicator.stopAnimating()
                self.collectionView?.reloadData()
            }
            for (index, _) in cardData.enumerated() {
                cardData[index].image = UIImage(named: "8.png")
            }
        
        } else {
            guard let search = currentSearch else {
                print("(controller, loadData(): No search configured")
                self.activityIndicator.stopAnimating()
                return
            }
            guard let text = searchField.text else {
                print("searchFiled text invalid")
                return
            }
            searchManager.search.searchTerm = text
            mtgAPISerivce.performSearch(search: searchManager.search) {
                results in
                
                if testManager {
                    self.cardManager = CardManager(json: results)
                    if let cards = self.cardManager?.returnUniqueCardsByAmount(amount: 12) {
                        self.cardData = cards
                        print("cardManager cards set")
                    }
                } else {
                   
                    if let cards = JSONParser.parser.createCardsRemovingDuplicatesByName(data: results) {
                        self.cardData = cards
                        print("carddata set")
                    }
                    
                }
               
                if useImages {
                    for (index, _) in self.cardData.enumerated() {
                        let card = self.cardData[index]
                        self.cardData[index].image = JSONParser.parser.getImageNoQueue(imageURL: card.imageURL)
                    }
                }
                
              
                
                DispatchQueue.main.async {
                    print("Closure called in func loadData")
                    self.activityIndicator.stopAnimating()
                    self.collectionView?.reloadData()
                }
            }
            
            
            
            print("right before end of load data")
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        
        currentSearch = Search()
        
        searchField.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetailSegue" {
            if let card = sender as? CardCell {
                let destinationController = segue.destination as! CardDetailViewController
                print("Card image \(card.cardData.image)")
                print("Card name \(card.cardData.name)")
                destinationController.image = card.cardData.image
              
            }
        }
        
        if segue.identifier == configSearchSegueID {
            let destinationVC = segue.destination as! ConfigSearchVC
            destinationVC.collectionView = self
            configVC = destinationVC
            
            let parameters = searchManager.search.parameters
            if !parameters.isEmpty {
                destinationVC.parameters = parameters
                destinationVC.groupParameters()
            }
            
        }
        
     }
    
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        
        selectedCell = cell as CardCell
        
        print("cell tapped")
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        if !useImages {
            cell.cardNameLabel.text = "# \(indexPath.row), \(card.name)"
            cell.backgroundColor = UIColor.gray
            //cell.cardImageView.image = cell.cardData.image
            return cell
        }
        
        cell.cardNameLabel.isHidden = true

        cell.cardImageView.image = cell.cardData.image
        
       // print("Cell Created, imageURL = \(cell.cardData.imageURL)")
        
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

//MARK: - FlowLayout delegate extension

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


//MARK: - Textfielddelegate extension
extension CardCollectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchTerm = textField.text {
            self.currentSearch = Search(term: searchTerm, parameters: .name)
        }
        
        
        return true
        
        
    }

    
    
    
}






extension CardCollectionViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else {
            print("previewingContext  indexpath fail")
            return nil
        }
        guard let cell = collectionView?.cellForItem(at: indexPath) as? CardCell else {
            print("previewingContext get cell for indexpath fail")
            return nil
        }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "cardDetailControllerID") as? CardDetailViewController else {
            print("previewingContext detailVC creation fail")
            return nil
        }
        
        let image = cell.cardData.image
        
        detailVC.image = image
        
        let width = view.frame.width/4
        
        detailVC.preferredContentSize = CGSize(width: width, height: width*cardSizeRatio)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        showDetailViewController(viewControllerToCommit, sender: self)
    }
}




extension CardCollectionViewController {
    
    @IBAction func configSearch() {
     print("config pressed")
        performSegue(withIdentifier: configSearchSegueID, sender: nil)
    }
}



//
