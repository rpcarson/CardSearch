//
//  PeekAndPop.swift
//  CardSearch
//
//  Created by Reed Carson on 2/16/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class PeekAndPopDelegate: NSObject, UIViewControllerPreviewingDelegate {
    
    var collectionVC: UICollectionViewController?
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionVC?.collectionView?.indexPathForItem(at: location) else {
            print("previewingContext  indexpath fail, got path: \(location)")
            return nil
        }
        guard let cell = collectionVC?.collectionView?.cellForItem(at: indexPath) as? CardCell else {
            print("previewingContext get cell for indexpath fail")
            return nil
        }
        
        guard let detailVC = collectionVC?.storyboard?.instantiateViewController(withIdentifier: previewVCStoryboardID) as? PreviewVC else {
            print("previewingContext detailVC creation fail")
            return nil
        }
        
        
        let image = cell.cardData.image
        
        detailVC.image = image
        
        detailVC.labelText = cell.cardData.name
        
        // print("CELL CARD DATA : \(cell.cardData)")
        
        detailVC.cardData = cell.cardData
        
        // let width = view.frame.width/3
        
        // let cardSizeRatio = dataSource.cardSizeRatio
        
        //detailVC.preferredContentSize = CGSize(width: width, height: width*cardSizeRatio)
        
        previewingContext.sourceRect = cell.frame
        
        //CGRect(x: view.frame.width/2, y: view.frame.height/2, width: width, height: width*cardSizeRatio)
        
        return detailVC
    
}
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        
        guard let detailVC = collectionVC?.storyboard?.instantiateViewController(withIdentifier: cardDetailVCID) as? CardDetailViewController else {
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
        
        collectionVC?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

//
//extension CardCollectionViewController: UIViewControllerPreviewingDelegate {
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        
//        guard let indexPath = collectionView?.indexPathForItem(at: location) else {
//            print("previewingContext  indexpath fail, got path: \(location)")
//            return nil
//        }
//        guard let cell = collectionView?.cellForItem(at: indexPath) as? CardCell else {
//            print("previewingContext get cell for indexpath fail")
//            return nil
//        }
//        
//        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: previewVCStoryboardID) as? PreviewVC else {
//            print("previewingContext detailVC creation fail")
//            return nil
//        }
//        
//        
//        let image = cell.cardData.image
//        
//        detailVC.image = image
//        
//        detailVC.labelText = cell.cardData.name
//        
//        // print("CELL CARD DATA : \(cell.cardData)")
//        
//        detailVC.cardData = cell.cardData
//        
//        // let width = view.frame.width/3
//        
//        // let cardSizeRatio = dataSource.cardSizeRatio
//        
//        //detailVC.preferredContentSize = CGSize(width: width, height: width*cardSizeRatio)
//        
//        previewingContext.sourceRect = cell.frame
//        
//        //CGRect(x: view.frame.width/2, y: view.frame.height/2, width: width, height: width*cardSizeRatio)
//        
//        return detailVC
//        
//    }
//    
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        
//        
//        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: cardDetailVCID) as? CardDetailViewController else {
//            print("problem loading detailVC")
//            return
//        }
//        if let image = (viewControllerToCommit as? PreviewVC)?.image {
//            detailVC.image = image
//        }
//        
//        if let card = (viewControllerToCommit as? PreviewVC)?.cardData {
//            detailVC.card = card
//            print("detailVC card set")
//        }
//        
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//}
