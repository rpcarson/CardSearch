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

let useImages = false


private let reuseIdentifier = "CardCellID"

//let testParse = true





class CardCollectionViewController: UICollectionViewController  {
    
    var dummyData = [Card]()
    
    var mtgAPISerivce = MTGAPIService()
    
   // var currentSearch: Search?
    
    var selectedCell: CardCell?
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    var cardManager: CardManager?
    
    
    var configVC: ConfigSearchVC?
    
    
    //var resultsLimit: Int = 12
    
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
        
        
        if useDummyData {
            for _ in 1...12 {
                dummyData.append(Card())
              
            }
            for (index, _) in dummyData.enumerated() {
                dummyData[index].image = UIImage(named: "8.png")
            }
            
            activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
        
        } else {
//            guard let search = searchManager.search else {
//                print("(controller, loadData(): No search configured")
//                self.activityIndicator.stopAnimating()
//                return
//            }
//            guard let term = searchField.text else {
//                print("searchFiled text invalid")
//                return
//            }
//            searchManager.updateSearchTerm(term: term)
          
            
            guard let url = searchManager.constructURLWithComponents() else {
                print("CardCollecitonViewController loadData construct URL fail")
                return
            }
            
            mtgAPISerivce.performSearch(url: url) {
                results in
                
              //  print(results)
                
                if testManager {
                    self.cardManager = CardManager(json: results)
                    if let cards = self.cardManager?.returnUniqueCards(amount: 12) {
                        self.dummyData = cards
                        print("cardManager cards set")
                    }
                } else {
                   
                    if let cards = JSONParser.parser.createCardsRemovingDuplicatesByName(data: results) {
                        self.dummyData = cards
                        print("carddata set")
                    }
                    
                }
               
                if useImages {
                    for (index, _) in self.dummyData.enumerated() {
                        let card = self.dummyData[index]
                        self.dummyData[index].image = JSONParser.parser.getImageNoQueue(imageURL: card.imageURL)
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
        return dummyData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        
        let card = dummyData[indexPath.row]
        
        cell.cardData = card
        
        if useDummyData {
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
