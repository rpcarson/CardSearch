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
    
    
    @IBOutlet weak var cardView: UIImageView!
    
    var image: UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.image = image
        
        
        
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
