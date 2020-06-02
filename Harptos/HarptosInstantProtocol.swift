//
//  HarptosInstant.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public protocol HarptosInstantProtocol {
    var epoch: Int { get }
    
    var year: Int { get }
    
    func byAdding(days: Int) -> HarptosInstantProtocol
}

public class HarptosInstant: HarptosInstantProtocol {
    lazy var components: HarptosDateComponents = {
        return Calendar.getDateComponentsFor(epoch: self.epoch)
    }()
    
    public let epoch: Int
    
    public var year: Int { self.components.year }
    
    init(epoch: Int) {
        self.epoch = epoch
    }
}

extension HarptosInstantProtocol {
    public func byAdding(days: Int) -> HarptosInstantProtocol {
        let epoch = self.epoch + days * Constants.minutesPerDay
        return HarptosCalendar.getInstant(epoch: epoch)
    }
    
    public func byAddingMonths(months: Int) -> HarptosInstantProtocol {
        let epoch = self.epoch + months * 30 * Constants.minutesPerDay
        return HarptosCalendar.getInstant(epoch: epoch)
    }
    
    public func byAddingYears(years: Int) -> HarptosInstantProtocol {
        let epoch = self.epoch + year * Constants.minutesPerYear
        return HarptosCalendar.getInstant(epoch: epoch)
    }
}
