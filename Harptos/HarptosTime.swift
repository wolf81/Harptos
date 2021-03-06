//
//  HarptosTime.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 05/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// A `HarptosTime` object represents a moment of time in the AD&D universe, based on the Calendar of
/// Harptos
public class HarptosTime {
    lazy var components: TimeComponents = {
        return Calendar.getDateComponentsFor(epoch: self.epoch)
    }()
        
    /// The epoch value in seconds, where 0 represents the time at 0 Dale Reckoning
    public let epoch: Int
            
    /// The month, will be nil in case of a festival
    public var month: Int? { self.components.month }
    
    /// The festival, will be nil in case of a month
    public var festival: HarptosFestival? { self.components.festival }
    
    /// The day
    public var day: Int { self.components.day }
    
    /// The year
    public var year: Int { self.components.year }
    
    /// The hour in the day
    public var hour: Int { self.components.hour }
    
    /// The minute in the current hour
    public var minute: Int { self.components.minute }
    
    /// The second in the current minute
    public var second: Int { self.components.second }
        
    /// The initializer
    /// - Parameter epoch: An epoch value in seconds, for which 0 represents the time at 0 Dale Reckoning
    init(epoch: Int) {
        self.epoch = epoch
    }
}

// Time manipulation functions

extension HarptosTime {
    
    /// Return a new time by adding days to the current time
    /// - Parameter days: The days to add, use negative values to subtract
    public func timeByAdding(days: Int) -> HarptosTime {
        let epoch = self.epoch + days * Constants.secondsPerDay
        return HarptosCalendar.getTimeFor(epoch: epoch)
    }
    
    /// Return a new time by adding months to the current time
    /// - Parameter months: The months to add, use negative values to subtract
    public func timeByAdding(months: Int) -> HarptosTime {
        let epoch = self.epoch + months * 30 * Constants.secondsPerDay
        return HarptosCalendar.getTimeFor(epoch: epoch)
    }
    
    /// Return a new time by adding years to the current time
    /// - Parameter years: The years to add, use negative values to subtract
    public func timeByAdding(years: Int) -> HarptosTime {
        let epoch = self.epoch + year * Constants.secondsPerYear
        return HarptosCalendar.getTimeFor(epoch: epoch)
    }
        
    /// Return a new time by adding seconds to the current time
    /// - Parameter seconds: The seconds to add, use negative values to subtract
    public func timeByAdding(seconds: Int) -> HarptosTime {
        let epoch = self.epoch + seconds
        return HarptosCalendar.getTimeFor(epoch: epoch)
    }
    
    /// Return a new time by adding minutes to the current time
    /// - Parameter minutes: The minutes to add, use negative values to subtract
    public func timeByAdding(minutes: Int) -> HarptosTime {
        let epoch = self.epoch + minutes * Constants.secondsPerMinute
        return HarptosCalendar.getTimeFor(epoch: epoch)
    }
        
    /// Return a new time by adding hours to the current time
    /// - Parameter hours: The hours to add, use negative values to subtract
    public func timeByAdding(hours: Int) -> HarptosTime {
        let epoch = self.epoch + hours * Constants.secondsPerHour
        return HarptosCalendar.getTimeFor(epoch: epoch)
    }
}

// MARK: - CustomStringConvertible

extension HarptosTime: CustomStringConvertible {
    private static let defaultFormatter = HarptosTimeFormatter(monthFormat: "dd MM YYYY 'DR' – hh:mm:ss", festivalFormat: "M YYYY 'DR' – hh:mm:ss")

    public var description: String {
        return HarptosTime.defaultFormatter.string(from: self)
    }
}
