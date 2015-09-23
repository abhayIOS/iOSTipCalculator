//
//  ViewController.swift
//  TipCalculator
//
//  Created by Abhay on 9/13/15.
//  Copyright © 2015 Abhay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

   
    @IBOutlet weak var txtCheckAmount: UITextField!
    
    @IBOutlet weak var lblCheckAmount: UILabel!
    @IBOutlet weak var lblSplit: UILabel!
    @IBOutlet weak var lblSplitValue: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTipValue: UILabel!
    @IBOutlet weak var lblTotalTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTipPerPerson: UILabel!
    @IBOutlet weak var lblTotalPerPerson: UILabel!
    
    @IBOutlet weak var lblTotalTipValue: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblTipPerPersonValue: UILabel!
    @IBOutlet weak var lblTotalPerPersonValue: UILabel!
    
    var currency:String = "";
    var currentSplit:Int = 1;
    var currentPercent:Int = 20;  // Inital % value
    var currentCheckAmount: Double = 00.00;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator";
        
        applyFonts();
        
        currency = "$";
    
        self.addDoneButtonOnKeyboard()
        
    }
    
    
    /**
        Convinence method to apply font to all the label and text fields
    */
    func applyFonts()
    {
        lblCheckAmount.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        txtCheckAmount.font = UIFont(name: "HelveticaNeue-Light", size: 40);
        
        lblSplit.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        lblSplitValue.font = UIFont(name: "HelveticaNeue-Light", size: 30);
        
        lblTip.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        lblTipValue.font = UIFont(name: "HelveticaNeue-Light", size: 30);
        
        lblTotalTip.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        lblTotalTipValue.font = UIFont(name: "HelveticaNeue-Light", size: 40);
        
        lblTotal.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        lblTotalValue.font = UIFont(name: "HelveticaNeue-Light", size: 40);
        
        lblTipPerPerson.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        lblTipPerPersonValue.font = UIFont(name: "HelveticaNeue-Light", size: 30);
        
        lblTotalPerPerson.font = UIFont(name: "HelveticaNeue-Light", size: 18);
        lblTotalPerPersonValue.font = UIFont(name: "HelveticaNeue-Light", size: 30);
        
//        let navigationBarAppearance = UINavigationBar.appearance()
//        
//        navigationBarAppearance.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 23)!,  NSForegroundColorAttributeName: UIColor.whiteColor()];

    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("viewKeyTouchDown:"))
        
        doneToolbar.items = [flexSpace,done];
        
        doneToolbar.sizeToFit()
        
        self.txtCheckAmount.inputAccessoryView = doneToolbar
        
    }
    
    /** 
        Key down and done button handler to hide the keyboard
    */
    @IBAction func viewKeyTouchDown(sender: AnyObject) {
        self.txtCheckAmount.resignFirstResponder()
    }
    
    /**
        % Slider change action method
    */
    @IBAction func percentageSliderChanged(sender: UISlider) {
    
        lblTipValue.text = "\(Int(sender.value))%";
        currentPercent = Int(sender.value);
        updateTotalAndTip();
    }
    
    /**
          Reduce split count
    */
    @IBAction func subSplit(sender: AnyObject) {
        
        if currentSplit  == 1 {
            return;
        } else {
            currentSplit  = currentSplit - 1;
        }
        
        lblSplitValue.text = String(currentSplit);
        updateTotalAndTip();
    }
    
    /**
        Increase split count
    */
    @IBAction func addSplit(sender: AnyObject) {
        
        if currentSplit  == 10 {
            return;
        } else {
            currentSplit  = currentSplit + 1;
        }
        lblSplitValue.text = String(currentSplit);
        
        updateTotalAndTip();
        
    }
    
    /**
    
        Method to calculate tip, total and update the UI. This method will be called when %, amount, split changes.
    
    */
    func updateTotalAndTip () {
        
        let result = Utility.calculatePercentage(currentCheckAmount, percent: currentPercent);
        
        lblTotalTipValue.text =  "\(currency)\(String (Double  (round (100 * result.tipAmount ) / 100) ))";
        lblTotalValue.text = "\(currency)\(String (Double  (round (100 * result.total ) / 100) ))";
        
        lblTipPerPersonValue.text = "\(currency)\(String (Double  (round (100 * (result.tipAmount / Double(currentSplit))) / 100) ))";
      
        lblTotalPerPersonValue.text = "\(currency)\(String (Double  (round (100 * (result.total / Double(currentSplit))) / 100) ))";
        
    }
    
    /**   
    
        TextField delegate methods
    
    */
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
        if (textField.text?.characters.count  == 9 && !string.isEmpty) {
            
            return false;
        }
        
        let  cleanCentString:String  = (textField.text?.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator(""))!;
        
        var centAmount: Int = Int(cleanCentString)!;
        
        if (string.isEmpty) {
            
            centAmount = centAmount / 10;
            
        } else {
            
            centAmount = centAmount * 10 + Int(string)!;
        }
        
        let amount: Double  = Double(centAmount) / 100.0;
        
        
        let formatter: NSNumberFormatter = NSNumberFormatter();
        
        formatter.numberStyle = .CurrencyStyle;
        formatter.currencyCode = "USD";
        formatter.negativeFormat = "-¤#,##0.00";
        textField.text = formatter.stringFromNumber(amount);
        
        return false;
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        var amountCopy:String =  (textField.text?.stringByReplacingOccurrencesOfString("$", withString: ""))!;
        
        amountCopy =  amountCopy.stringByReplacingOccurrencesOfString(",", withString: "");
        
        currentCheckAmount = Double(amountCopy)!;
        updateTotalAndTip();
        
        
    }


    
}

