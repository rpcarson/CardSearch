//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


//MARK: - dev settings

var testCard: Card = {
    var card = Card()
    card.name = "Allosaurus"
    card.set = "Worst"
    card.colors = ["Blue"]
    card.rulings = [["date":"10-11-12","text":"something more appropriate"],["date":"11-12-13","text":"cant do this or that rule "],["date":"11-12222-13","text":"cant 1212212use to wipe"],["date":"33-12-13","text":"cant useTHISRULING IS ULTRA LONG AND PRObably reflects the elgnth of the average ruling im gonna get back form the json results 3333to"],["date":"11-112122-13","text":"cant use to randomtext randomt radnomdd"]]
    card.image = UIImage(named: "8.png")

    return card
}()

let testingSets = false

let testingPageSize = "100"
let testingResultsToDisplay = 100


let autoLoad = false

let useDummyData = false

let useDebuggerCells = true

let useImages = true

let reuseIdentifier = "CardCellID"
let configSearchSegueID = "ConfigSearchSegue"

class CardCollectionViewController: UICollectionViewController  {
    
   lazy var dummyData: [Card] = {
        var data = [Card]()
        for i in 1...36 {
            data.append(testCard)
        }
        return data

    }()
    
    var mtgAPISerivce = MTGAPIService()
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
   // var configVC: ConfigSearchVC?
    
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
    
    func performSearch(completion: @escaping () -> Void) {
        searchManager.updateSearchTerm(term: searchTerm)
        
        guard let url = searchManager.constructURLWithComponents() else {
            print("CardCollectionVC:performSearch - url construction failed")
            return
        }
        
        
        // guard let url = testURL else { print("BAD URL") ; return }
        
        mtgAPISerivce.performSearch(url: url) {
            results in
            
            self.dataSource.cardManager.createUniqueCardsWithMaxFromJSON(json: results, amount: testingResultsToDisplay)
            print("CCVC cardManager.createUniqueCardsWithMaxFromJSON called in performSearch closure")
            
            completion()
        }
    }
    
    let peekAndPopDelegate = PeekAndPopDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if autoLoad && useDummyData {
            loadData()
        }
        
        peekAndPopDelegate.collectionVC = self
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: peekAndPopDelegate, sourceView: collectionView!)
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
          //  configVC = destinationVC
            
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


//
