//
//  HarptosInstant.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public protocol HarptosInstant {
    var epoch: Int { get }
    
    var year: Int { get }
    
    func byAdding(days: Int) -> HarptosInstant
}

extension HarptosInstant {
    public func byAdding(days: Int) -> HarptosInstant {
        let epoch = self.epoch + days * Constants.minutesPerDay
        return HarptosCalendar.getDateFor(epoch: epoch)
    }
    
    public func byAddingMonths(months: Int) -> HarptosInstant {
        let epoch = self.epoch + months * 30 * Constants.minutesPerDay
        return HarptosCalendar.getDateFor(epoch: epoch)
    }
    
    public func byAddingYears(years: Int) -> HarptosInstant {
        let epoch = self.epoch + year * Constants.minutesPerYear
        return HarptosCalendar.getDateFor(epoch: epoch)
    }
}

