//
//  Utility.swift
//  TipCalculator
//
//  Created by Abhay on 9/17/15.
//  Copyright © 2015 Abhay. All rights reserved.
//

import WatchKit

class Utility: NSObject {
    
    /**
        Calculate % and return tip amount and total in tupal
    
    */
    class func calculatePercentage(checkAmount: Double, percent: Int ) -> (tipAmount: Double, total: Double) {
        
        let tip = Double(checkAmount * (Double(percent) / Double(100)));
        
        let roundedTip = Double(round(100 * tip) / 100);
        
        let totalRounded = Double(round(100 * (checkAmount + tip)) / 100);
        
        return (roundedTip, totalRounded);
    }

}
