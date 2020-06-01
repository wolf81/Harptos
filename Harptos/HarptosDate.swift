//
//  HarptosDate.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public struct HarptosDate {
    let epoch: Int

    var year: Int {
        return Calendar.getYearFor(epoch: self.epoch)
    }
    
    var month: Int {
        return Calendar.getMonthFor(epoch: self.epoch)
    }
    
    var day: Int {
        return Calendar.getDayFor(epoch: self.epoch)        
    }
    
    public init(epoch: Int) {
        self.epoch = epoch
    }
    
    public init(year: Int, month: Int, day: Int) {
        print("\(year), \(month), \(day)")
        self.epoch = Calendar.getEpochFor(year: year, month: month, day: day)
    }
}
