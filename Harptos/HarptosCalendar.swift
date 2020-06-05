//
//  Calendar.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// The HarptosCalendar can be used to create HarptosTime objects
public final class HarptosCalendar {
    
    /// Return a time for a given year, month & day
    /// - Parameters:
    ///   - year: The year, it's recommended to limit the range from -700 DR to 1600 DR
    ///   - month: A value between 1 and 12
    ///   - day: A value between 1 and 30
    public static func getTimeFor(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> HarptosTime {
        assert((1 ... 12).contains(month), "Months should be between 1 and 12")
        assert((1 ... 30).contains(day), "Days should be between 1 and 30")
        assert((0 ..< 24).contains(hour), "Hours should be between 0 and 23")
        assert((0 ..< 60).contains(minute), "Minutes should be between 0 and 59")
        assert((0 ..< 60).contains(second), "Seconds should be between 0 and 59")
        
        let segment = YearTimeSegment.getSegmentIndexFor(month: month)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: day, hour: hour, minute: minute, second: second)
        return HarptosTime(epoch: epoch)
    }
        
    /// Return a time for a given year and festival
    /// - Parameters:
    ///   - year: The year, it's recommended to limit the range from -700 DR to 1600 DR
    ///   - festival: A festival
    public static func getTimeFor(year: Int, festival: HarptosFestival, hour: Int = 0, minute: Int = 0, second: Int = 0) -> HarptosTime {
        assert((0 ..< 24).contains(hour), "Hours should be between 0 and 23")
        assert((0 ..< 60).contains(minute), "Minutes should be between 0 and 59")
        assert((0 ..< 60).contains(second), "Seconds should be between 0 and 59")

        if festival == .shieldmeet { assert(Calendar.isLeapYear(year), "Shieldmeet can only occur on leap years") }
        
        let segment = YearTimeSegment.getSegmentIndexFor(festival: festival)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: 1, hour: hour, minute: minute, second: second)
        return HarptosTime(epoch: epoch)
    }
        
    /// Return a time object for a given epoch, where 0 is equal to 0 Dale Reckoning
    /// - Parameter epoch: The epoch
    public static func getTimeFor(epoch: Int) -> HarptosTime {
        return HarptosTime(epoch: epoch)
    }    
}

// MARK: - Retrieve human-readable names for years, months & festivals

extension HarptosCalendar {
    
    /// Return the name for the year, will be nil if the year is not in range (-700 ... 1600)
    /// - Parameter year: The year to return the name for
    public static func getNameFor(year: Int) -> String? {
        return Calendar.getNameFor(year: year)
    }
    
    /// Return the names for a month; the first name is the most common name, but can be followed by alternate names
    /// - Parameter month: The month to return the name for
    public static func getNamesFor(month: Int) -> [String] {
        let segment = YearTimeSegment(month: month)
        return [segment.name] + segment.alternateNames
    }
        
    /// Return the name for a festival
    /// - Parameter festival: The festival to return the name for
    public static func getNameFor(festival: HarptosFestival) -> String {
        let segment = YearTimeSegment(festival: festival)
        return segment.name
    }
}
