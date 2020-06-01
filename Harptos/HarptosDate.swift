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
        let (years, remainderMonths) = self.epoch.quotientAndRemainder(dividingBy: Constants.minutesPerYear)
        var days = remainderMonths / Constants.minutesPerDay
        let leapDays = years / 4

        days = (((days - leapDays) + 365) % 365)
                    
        for m in Month.allCases {
            let daysInMonth = m.holiday != nil ? 31 : 30
            
            if days <= daysInMonth { break }
            
            days -= daysInMonth
        }

        // if day is 31 of holiday months, day is not decreased
        // if day is 32 of month 7 in leap year, month is not incremented

        return days
    }
    
    public init(epoch: Int) {
        self.epoch = epoch
    }
    
    public init(year: Int, month: Int, day: Int) {
        print("\(year), \(month), \(day)")
        self.epoch = Calendar.getEpochFor(year: year, month: month, day: day)
    }
}
