//
//  InterfaceController.swift
//  TipCalculator WatchKit Extension
//
//  Created by Abhay on 9/13/15.
//  Copyright © 2015 Abhay. All rights reserved.
//

import WatchKit
import Foundation




class InterfaceController: WKInterfaceController {

    @IBOutlet var decPicker: WKInterfacePicker!
    @IBOutlet var prePicker: WKInterfacePicker!
    @IBOutlet var percentPicker: WKInterfacePicker!
    
    @IBOutlet var tipAmountTxt: WKInterfaceLabel!
    @IBOutlet var totaltxt: WKInterfaceLabel!
    
    
    var currentDecValue:Int = 0;
    var currentPreValue:Int = 0;
    var currentPerValue:Int = 0;
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        setPickerDataSets();
        
        
    }
    
    // Custom methods
    
    @IBAction func decChanged(value: Int) {
        
        
        currentDecValue = value;
        calculatePerAndSetValue();
        
    }
    
    
    @IBAction func preChanged(value: Int) {
        
        currentPreValue = value;
        calculatePerAndSetValue();
        
    }
    
    
    @IBAction func percentChanged(value: Int) {
        
        currentPerValue = value;
        calculatePerAndSetValue();
        
    }
    
    
    func setPickerDataSets() {
        
        var decPickerItems : [WKPickerItem] = [];
        var prePickerItems : [WKPickerItem] = [];
        var perPickerItems : [WKPickerItem] = [];
        
        for index in 0...400 {
            let item = WKPickerItem();
            
            if index <= 9 {
                item.title = "0\(index)";
            }
            else {
                item.title = "\(index)";
            }
            
            decPickerItems.append(item);
        }
        
        for index in 0...99 {
            let item = WKPickerItem();
            if index <= 9 {
                item.title = "0\(index)";
            }
            else {
                item.title = "\(index)";
            }

            prePickerItems.append(item);
        }
        
        
        for indexi in 0...50 {
            let item = WKPickerItem();
            item.title = "\(indexi )";
            perPickerItems.append(item);
        }
        
        
        
        decPicker.setItems(decPickerItems);
        prePicker.setItems(prePickerItems);
        percentPicker.setItems(perPickerItems);
        
        percentPicker.setSelectedItemIndex(20);
        
    }
    
    
    func calculatePerAndSetValue() {
        
        let checkAmount: Double = Double("\(currentDecValue).\(currentPreValue)")!;
        
        let result = Utility.calculatePercentage(checkAmount, percent: currentPerValue);
    
        tipAmountTxt.setText("$" + String(result.tipAmount)); totaltxt.setText("$" + String (result.total));
        
    }
    
}
