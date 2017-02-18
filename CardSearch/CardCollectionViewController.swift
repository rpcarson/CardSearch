//
//  CardCollectionViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

private let configSearchSegueID = "ConfigSearchSegue"

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
    
    var searchManager = SearchManager()
    
    var dataSource = SearchCollectionViewDatasource()
    
    let peekAndPopDelegate = PeekAndPopDelegate()
    
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
    
    
    private func downloadSets() {
        mtgAPISerivce.downloadSetsData { (results) in
            var names = [String]()
            var code = [String]()
            var blox = [String]()
            
            
            let sets = JSONParser.parser.parseSetsJSONData(json: results)
            
            guard let data = JSONParser.parser.parseSetsJSONData(json: results) else { return }
            
            let blocks = JSONParser.parser.getBlocksFromSetData(sets: data)
           
            for b in blocks {
                print("Blocks - \n Name: \(b.name) \n Sets: \(b.sets)")

            }
            
            return
            
            if let set = results["sets"] as? [[String:Any]] {
                print("sets")
                for s in set {
                    print(s.description)
                    if let blok = s["block"] as? String {
                        print("BLOK \(blok)")
                    }
                }
            }
            
            
            for set in sets! {
                
                names.append(set.name)
                code.append(set.code)
                
                if set.block != "" {
                    print(set.block)
                    blox.append(set.block)
                }
                
            }
            
            // print(results)
            print(blox)
            print(blox.count)
        }
    }
    
    
    
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
        
        if testingSets {  downloadSets() }
    
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
