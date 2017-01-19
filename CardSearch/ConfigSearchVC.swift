//
//  ConfigSearchVC.swift
//  CardSearch
//
//  Created by Reed Carson on 1/19/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

class ColorPVSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let data = ["red", "green", "blue", "white", "black", "colorless"]
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
class TypePVSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let data = ["creature", "sorcery", "instant"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
class NumberPVSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let data = ["6", "12", "18", "24"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

class ConfigSearchVC: UIViewController {

    @IBOutlet weak var colorPicker: UIPickerView!
     @IBOutlet weak var typePicker: UIPickerView!
     @IBOutlet weak var cmcPicker: UIPickerView!
    
    let colorDatasource = ColorPVSource()
    let typeDatasource = TypePVSource()
    let cmcDatasource = NumberPVSource()
    
    var collectionView: CardCollectionViewController?
    
    
    @IBAction func backToCollectionView() {
        print("backToCollectionView called")
        let index = cmcPicker.selectedRow(inComponent: 0)
        
        print(cmcDatasource.data.count)
        
        if let limit = Int(cmcDatasource.data[index]) {
            print("pickerview selection \(limit)")
            collectionView?.resultsLimit = limit
        }
        self.dismiss(animated: true, completion: nil)
    }
    


    
//    func configNavbar() {
//        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ConfigSearchVC.backToCollectionView))
//        navigationItem.setRightBarButton(doneButton, animated: true)
//    }
    
//    func backToCollectionView() {
//        print("backToCollectionView called")
//        let index = cmcPicker.selectedRow(inComponent: 1)
//        if let limit = Int(cmcDatasource.data[index]) {
//            print("pickerview selection \(limit)")
//            collectionView?.resultsLimit = limit
//        }
//         dismiss(animated: true, completion: nil)
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  configNavbar()
        
        colorPicker.dataSource = colorDatasource
        colorPicker.delegate = colorDatasource
        typePicker.dataSource = typeDatasource
        typePicker.delegate = typeDatasource
        cmcPicker.dataSource = cmcDatasource
        cmcPicker.delegate = cmcDatasource

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
