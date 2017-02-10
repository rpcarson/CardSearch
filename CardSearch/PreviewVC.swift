//
//  PreviewVC.swift
//  CardSearch
//
//  Created by Reed Carson on 2/9/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

let previewVCStoryboardID = "previewVCID"

class PreviewVC: UIViewController {

  
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    var image: UIImage?
    var labelText: String?
    
    
    var cardData: Card?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardImageView.image = image
        cardNameLabel.text = labelText
        
        view.backgroundColor = UIColor.clear
    
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
