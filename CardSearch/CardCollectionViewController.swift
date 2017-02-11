//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit




let testingSets = false

let testingPageSize = "6"
let testingResultsToDisplay = 36


let autoLoad = false

let useDummyData = false

let useDebuggerCells = true

let useImages = true

let reuseIdentifier = "CardCellID"
let configSearchSegueID = "ConfigSearchSegue"



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
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var configVC: ConfigSearchVC?
    
    var searchManager = SearchManager()
    
    var dataSource = SearchCollectionViewDatasource()
    
    @IBOutlet weak var searchField: UITextField!
    
    var searchTerm: String? {
        return searchField.text != nil ? searchField.text : ""
    }
    
    
    @IBAction func configSearch() {
        print("config pressed")
        performSegue(withIdentifier: configSearchSegueID, sender: nil)
    }
    
    func performSearch(completion: @escaping () -> Void) {
        searchManager.updateSearchTerm(term: searchTerm)
        guard let url = searchManager.constructURLWithComponents() else {
            print("CardCollectionVC:performSearch - url construction failed")
            return
        }
        
        mtgAPISerivce.performSearch(url: url) {
            results in
            
            self.dataSource.cardManager.createUniqueCardsWithMaxFromJSON(json: results, amount: testingResultsToDisplay)
            print("CCVC cardManager.createUniqueCardsWithMaxFromJSON called in performSearch closure")
            
            completion()
        }
    }
    
    
    @IBAction func loadData() {
        
    
        
        if !useDummyData {
            searchField.addSubview(activityIndicator)
            activityIndicator.frame = searchField.bounds
            activityIndicator.startAnimating()
        }
   
        
        if useDummyData {
            dataSource.cardManager.cards = dummyData
            activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
            return
        }
        
        if testingSets {
            
            mtgAPISerivce.downloadSetsData {
                data in
                
                if let sets = JSONParser.parser.parseSetsJSONData(json: data) {
                    print("SETS: \(sets)")
                }
                
            }
            
            
            return
        }
        
        
        
        performSearch {
            
            DispatchQueue.main.async {
                print("CCVC DispatchMain in peformSearch closure")
                self.activityIndicator.stopAnimating()
                self.collectionView?.reloadData()
                
                for card in self.dataSource.cardManager.cards {
                    print("CARDS IN CARDMAN \(card.name)")
                }
                
            }
            
        }
        
        print("ending loadData")
        return
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  navigationController?.prefersStatusBarHidden = false

        
        if autoLoad && useDummyData {
            loadData()
        }
        
        
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
            if let cardCell = sender as? CardCell {
                let destinationController = segue.destination as! CardDetailViewController
                print("Card image \(cardCell.cardData.image)")
                print("Card name \(cardCell.cardData.name)")
                destinationController.image = cardCell.cardData.image
                destinationController.card = cardCell.cardData
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

//MARK: - PeekNPop Delegate

extension CardCollectionViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else {
            print("previewingContext  indexpath fail, got path: \(location)")
            return nil
        }
        guard let cell = collectionView?.cellForItem(at: indexPath) as? CardCell else {
            print("previewingContext get cell for indexpath fail")
            return nil
        }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: previewVCStoryboardID) as? PreviewVC else {
            print("previewingContext detailVC creation fail")
            return nil
        }
        
        
        let image = cell.cardData.image
        
        detailVC.image = image
        
        detailVC.labelText = cell.cardData.name
        
        print("CELL CARD DATA : \(cell.cardData)")
        
        detailVC.cardData = cell.cardData
        
       // let width = view.frame.width/3
        
       // let cardSizeRatio = dataSource.cardSizeRatio
        
        //detailVC.preferredContentSize = CGSize(width: width, height: width*cardSizeRatio)
        
        previewingContext.sourceRect = cell.frame
            
            //CGRect(x: view.frame.width/2, y: view.frame.height/2, width: width, height: width*cardSizeRatio)
        
        return detailVC
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: cardDetailVCID) as? CardDetailViewController else {
            print("problem loading detailVC")
            return
        }
        if let image = (viewControllerToCommit as? PreviewVC)?.image {
              detailVC.image = image
        }
        
        if let card = (viewControllerToCommit as? PreviewVC)?.cardData {
            detailVC.card = card
            print("detailVC card set")
        }
      
        navigationController?.pushViewController(detailVC, animated: true)
    }
}




//
