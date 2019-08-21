//
//  ViewController.swift
//  HarryWei-Lab1
//
//  Created by Harry Wei on 9/9/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    let currency = ["US Currency $", "EU Pound £"]
    var currentCurrency = "US Currency $";
    
    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discountPercentage: UITextField!
    @IBOutlet weak var saletaxPercentage: UITextField!
    @IBOutlet weak var calculateValue: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        currentCurrency = currency[row]
        getOriginalPrice((Any).self)
    }
    
    @IBAction func getOriginalPrice(_ sender: Any) {
        let priceOriginal = Float(originalPrice.text!)
        let percentDiscount = Float(discountPercentage.text!)
        let percentSaleTax = Float(saletaxPercentage.text!)
        
        if(priceOriginal != nil && percentDiscount != nil && percentSaleTax != nil ){
            if(priceOriginal! < 0){
                calculateValue.text = "Original Price cannot be zero"
            }
            else if(percentDiscount! < 0 || percentDiscount! > 100){
                calculateValue.text = "Invalid Discount Percentage"
            }
            else if(percentSaleTax! < 0 || percentSaleTax! > 100){
                calculateValue.text = "Invalid Sale Tax Percentage"
            
            }
            else{
                let discountedPrice =  priceOriginal! - percentDiscount!/100 * priceOriginal!
                if(currentCurrency == "US Currency $"){
                    let finalPrice = discountedPrice + percentSaleTax!/100 * priceOriginal!
                    calculateValue.text =  currentCurrency + "\(String(format: "%.2f", finalPrice))"
                }
                else if(currentCurrency == "EU Pound £"){
                    let finalPrice = (discountedPrice + percentSaleTax!/100 * priceOriginal!) / 0.86
                    calculateValue.text =  currentCurrency + "\(String(format: "%.2f", finalPrice))"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
        
        // Do any additional setup after loading the view, typically from a nib.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

