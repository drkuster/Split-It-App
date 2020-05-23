//
//  TipModel.swift
//  Split It!
//
//  Created by Dylan Kuster on 5/7/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

class SplitModel
{
    static let shared = SplitModel()
    
    var billTotal : Float = 0.00
    var tipPercent : Float = 0.00
    var peopleSplit : Int = 0
    
    func calculateTotalPer() -> String
    {
        let total = (billTotal * tipPercent) + billTotal
        let totalPer = total / Float(peopleSplit)
        
        return String(format : "%.2f", totalPer)
    }
}
