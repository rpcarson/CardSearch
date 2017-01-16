//
//  CardDetailViewController.swift
//  CardSearch
//
//  Created by Reed Carson on 1/16/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    let storyboardID = "cardDetailControllerID"
    
    var swipeRecognizer = UISwipeGestureRecognizer()
    
    @IBOutlet weak var cardView: UIImageView!
    
    var image: UIImage?
    
    func swipeToDismiss() {
        print("swipe detected")
        dismiss(animated: true, completion: nil)
    }
    
    func setupGestureRecognizer() {
        swipeRecognizer.addTarget(self, action: #selector(CardDetailViewController.swipeToDismiss))
        cardView.addGestureRecognizer(swipeRecognizer)
        cardView.isUserInteractionEnabled = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestureRecognizer()

        cardView.image = image
        
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
