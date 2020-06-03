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
    
    func instantByAdding(days: Int) -> HarptosInstantProtocol
    
    func instantByAdding(months: Int) -> HarptosInstantProtocol

    func instantByAdding(years: Int) -> HarptosInstantProtocol
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
    public func instantByAdding(days: Int) -> HarptosInstantProtocol {
        print("epoch1: \(self.epoch)")
        
        let epoch = self.epoch + days * Constants.minutesPerDay
        let instant = HarptosCalendar.getInstant(epoch: epoch)
        
        print("epoch2: \(instant.epoch)")
        
        return instant
    }
    
    public func instantByAdding(months: Int) -> HarptosInstantProtocol {
        let epoch = self.epoch + months * 30 * Constants.minutesPerDay
        return HarptosCalendar.getInstant(epoch: epoch)
    }
    
    public func instantByAdding(years: Int) -> HarptosInstantProtocol {
        let epoch = self.epoch + year * Constants.minutesPerYear
        return HarptosCalendar.getInstant(epoch: epoch)
    }
}

