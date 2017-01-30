//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

let configSearchSegueID = "ConfigSearchSegue"

let useDummyData = false

let useDebuggerCells = true

let testManager = true

let useImages = true

let testRefactoredSearch = true

let reuseIdentifier = "CardCellID"


class CardCollectionViewController: UICollectionViewController  {
    
    var dummyData: [Card] = {
        var data = [Card]()
        for i in 1...24 {
            var card = Card()
            card.image = UIImage(named: "8.png")
            data.append(card)
        }
        return data
    }()
    
    var mtgAPISerivce = MTGAPIService()
    
   // var currentSearch: Search?
    
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    

    var configVC: ConfigSearchVC?
    
    var searchManager = SearchManager()
  //  var dataSource.cardManager = CardManager()
    
    var dataSource = SearchCollectionViewDatasource()

    
    @IBOutlet weak var searchField: UITextField!
    
    
    var searchTerm: String? {
        return searchField.text != nil ? searchField.text : ""
    }
    
    
    let cardsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 40.0, left: 15.0, bottom: 40.0, right: 15.0)
    let cardSize = CGSize(width: 63, height: 88)
    var cardSizeRatio: CGFloat {
        return cardSize.height/cardSize.width
    }
    
    
    func performSearch(completion: @escaping () -> Void) {
        searchManager.updateSearchTerm(term: searchTerm)
        guard let url = searchManager.constructURLWithComponents() else {
            print("CardCollectionVC:performSearch - url construction failed")
            return
    }
        
        mtgAPISerivce.performSearch(url: url) {
            results in

            self.dataSource.cardManager.createUniqueCardsWithMaxFromJSON(json: results, amount: 6)
            print("CCVC cardManager.createUniqueCardsWithMaxFromJSON called in performSearch closure")
            
            
            completion()
            
        }
        
        
    }
    
    
    @IBAction func loadData() {
        
        searchField.addSubview(activityIndicator)
        activityIndicator.frame = searchField.bounds
        activityIndicator.startAnimating()
        
        
        if testRefactoredSearch {
            
            performSearch {
                
                DispatchQueue.main.async {
                    print("CCVC DispatchMain in peformSearch closure")
                    self.activityIndicator.stopAnimating()
                    self.collectionView?.reloadData()
                }
                
            }
            
            print("ending loadData")
            return
        }
        
        
        if useDummyData {
            dataSource.cardManager.cards = dummyData
            activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
        
        } else {

            guard let term = searchField.text else {
                print("searchFiled text invalid")
                return
            }
            
          
            
            searchManager.updateSearchTerm(term: term)
          
            
            
            
            guard let url = searchManager.constructURLWithComponents() else {
                print("CardCollecitonViewController:loadData construct URL fail")
                return
            }
            
           
            
            print(url)
            
            mtgAPISerivce.performSearch(url: url) {
                results in
                
              //  print(results)
                
                if testManager {
                    self.dataSource.cardManager = CardManager(json: results)
                    if let cards = self.dataSource.cardManager.returnUniqueCards(amount: 12) {
                        self.dataSource.cardManager.cards = cards
                        print("cardManager cards set")
                    }
                } else {
                   
                    if let cards = JSONParser.parser.createCardsRemovingDuplicatesByName(data: results) {
                        self.dataSource.cardManager.cards = cards
                        print("carddata set")
                    }
                    
                }
               
                if useImages {
                    for (index, _) in self.dataSource.cardManager.cards.enumerated() {
                        let card = self.dataSource.cardManager.cards[index]
                        self.dataSource.cardManager.cards[index].image = JSONParser.parser.getImageNoQueue(imageURL: card.imageURL)
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
            registerForPreviewing(with: self, sourceView: collectionView!)
        }
        
        searchField.delegate = self
        
        collectionView?.dataSource = dataSource
        collectionView?.delegate = dataSource
        

    }
    
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetailSegue" {
            if let card = sender as? CardCell {
                let destinationController = segue.destination as! CardDetailViewController
                print("Card image \(card.cardData.image)")
                print("Card name \(card.cardData.name)")
                destinationController.image = card.cardData.image
                if activityIndicator.isAnimating {
                    activityIndicator.stopAnimating()
                }
              
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
    
    
//    // MARK: UICollectionViewDataSource
//    
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataSource.cardManager.cards.count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
//        
//        let card = dataSource.cardManager.cards[indexPath.row]
//        
//        cell.cardData = card
//        
//        if useDummyData {
//            cell.cardNameLabel.text = String(describing: indexPath.row)
//            cell.backgroundColor = UIColor.gray
//            return cell
//        }
//        
//        if !useImages {
//            cell.cardNameLabel.text = "# \(indexPath.row), \(card.name)"
//            cell.backgroundColor = UIColor.gray
//            //cell.cardImageView.image = cell.cardData.image
//            return cell
//        }
//        
//        cell.cardNameLabel.isHidden = true
//
//        return cell
//    }
//    
//    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        
//        let card = dataSource.cardManager.cards[indexPath.row]
//        guard let image = JSONParser.parser.getImageNoQueue(imageURL: card.imageURL) else {
//            print("CCVC:willDisplayCell  - no card image retrieved")
//            // TODO - display question mark
//            return
//        }
//        
//        (cell as! CardCell).setImage(image: image, andDisplay: true)
//        
//        print("CCVC willDisplayCell  card.image set")
//        
//        
//    }
//    
//    
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
            searchManager.updateSearchTerm(term: searchTerm)
        }
        return true
    }

    
    
    
}






extension CardCollectionViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        
      

        guard let indexPath = collectionView?.indexPathForItem(at: location) else {
            print("previewingContext  indexpath fail, got path: \(location)")
            return nil
        }
        print(indexPath)
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
        
        let width = view.frame.width/3
        
        
        detailVC.preferredContentSize = CGSize(width: width, height: width*cardSizeRatio)
//
  
       
        previewingContext.sourceRect = CGRect(x: view.frame.width/2, y: view.frame.height/2, width: width, height: width*cardSizeRatio)
        
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
