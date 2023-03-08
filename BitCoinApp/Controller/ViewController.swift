//
//  ViewController.swift
//  BitCoinApp
//
//  Created by Taras on 06/03/2023.
//

import UIKit



class ViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {
    
    let coinManager = CoinManager()
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

//    this is for title of each row
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
// this one will be called each time when user scrool the picker and return nubmer of row is selected.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    
    
// this is number of columns in the picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
// this is number of rows in the picker
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    
    
}


