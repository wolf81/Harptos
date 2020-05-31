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
        var (years, remainderMonths) = self.epoch.quotientAndRemainder(dividingBy: Constants.minutesPerYear)
                
        if remainderMonths < 0 {
            years -= 1
        }
                    
        return years
    }
    
    var month: Int {
        let (years, remainderMonths) = self.epoch.quotientAndRemainder(dividingBy: Constants.minutesPerYear)
        var days = remainderMonths / Constants.minutesPerDay
        let leapDays = years / 4

        days = (((days - leapDays) + 365) % 365)
        
        let months = days / 30
        
        return months
    }
    
    var day: Int {
        let (years, remainderMonths) = self.epoch.quotientAndRemainder(dividingBy: Constants.minutesPerYear)
        var days = remainderMonths / Constants.minutesPerDay
        let leapDays = years / 4

        days = (((days - leapDays) + 365) % 365)
                    
        for m in Month.allCases {
            if days <= 30 { break }
            
            days -= 30
            if m.holiday != nil {
                days -= 1
            }
        }
        
        return days
    }
    
    public init(epoch: Int) {
        self.epoch = epoch
    }
    
    public init(year: Int, month: Int, day: Int) {
        self.epoch = Calendar.getEpochFor(year: year, month: month, day: day)
    }
}
