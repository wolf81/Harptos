//
//  HarptosInstantProtocol.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// This protocol is used when generating new HarptosInstant objects from existing HarptosInstant objects
/// HarptosInstant objects could be either of type HarptosDate or HarptosFestival 
public protocol HarptosInstantProtocol {
    
    /// The epoch, for which 0 represents 0 DR
    var epoch: Int { get }
        
    /// The year - when dealing with years it's advised to limit the years to the range -700 ... 1600
    var year: Int { get }
        
    /// Create a new HarptosInstant object by adding a given amount of days
    /// - Parameter days: The days to add - use negative values to subtract days
    func instantByAdding(days: Int) -> HarptosInstantProtocol
    
    /// Create a new HarptosInstant object by adding a given amount of months
    /// - Parameter months: The months to add - use negative values to subtract months
    func instantByAdding(months: Int) -> HarptosInstantProtocol

    /// Create a new HarptosInstant object by adding a given amount of days
    /// - Parameter years: The years to add - use negative values to subtract years
    func instantByAdding(years: Int) -> HarptosInstantProtocol
}

/// A HarptosInstant provides the base functionality required to conform to HarptosInstantProtocol
public class HarptosInstant: HarptosInstantProtocol {
    lazy var components: InstantComponents = {
        return Calendar.getDateComponentsFor(epoch: self.epoch)
    }()
    
    /// The epoch
    public let epoch: Int
        
    /// The year
    public var year: Int { self.components.year }
        
    /// The initializer
    /// - Parameter epoch: An epoch value, for which 0 represents 0 DR
    init(epoch: Int) {
        self.epoch = epoch
    }
}

extension HarptosInstantProtocol {    
    public func instantByAdding(days: Int) -> HarptosInstantProtocol {
        let epoch = self.epoch + days * Constants.minutesPerDay
        return HarptosCalendar.getInstant(epoch: epoch)
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

