//
//  Calendar.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// The HarptosCalendar can be used to create HarptosDate & HarptosFestival objects
public final class HarptosCalendar {
    
    /// Return a HarptosDate object for a given year, month & day
    /// - Parameters:
    ///   - year: The year, it's recommended to limit the range from -700 DR to 1600 DR
    ///   - month: A value between 1 and 12
    ///   - day: A value between 1 and 30
    public static func getDateFor(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> HarptosDate {
        assert((1 ... 12).contains(month), "Months should be between 1 and 12")
        assert((1 ... 30).contains(day), "Days should be between 1 and 30")
        assert((0 ..< 24).contains(hour), "Hours should be between 0 and 23")
        assert((0 ..< 60).contains(minute), "Minutes should be between 0 and 59")
        assert((0 ..< 60).contains(second), "Seconds should be between 0 and 59")
        
        let segment = InstantSegment.getSegmentIndexFor(month: month)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: day, hour: hour, minute: minute, second: second)
        return HarptosDate(epoch: epoch)
    }
        
    /// Return a HarptosFestival object for a given year and festival
    /// - Parameters:
    ///   - year: The year, it's recommended to limit the range from -700 DR to 1600 DR
    ///   - festival: A festival
    public static func getFestivalFor(year: Int, festival: Festival, hour: Int = 0, minute: Int = 0, second: Int = 0) -> HarptosFestival {
        assert((0 ..< 24).contains(hour), "Hours should be between 0 and 23")
        assert((0 ..< 60).contains(minute), "Minutes should be between 0 and 59")
        assert((0 ..< 60).contains(second), "Seconds should be between 0 and 59")

        if festival == .shieldmeet { assert(year % 4 == 0, "Shieldmeet can only occur on leap years") }
        
        let segment = InstantSegment.getSegmentIndexFor(festival: festival)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: 1, hour: hour, minute: minute, second: second)
        return HarptosFestival(epoch: epoch)
    }
        
    /// Return either a HarptosDate or HarptosFestival for a given epoch
    /// - Parameter epoch: The epoch value for with 0 represents 0 DR
    public static func getInstantFor(epoch: Int) -> HarptosInstantProtocol {
        let components = Calendar.getDateComponentsFor(epoch: epoch)
        if components.segment.isFestival {
            return HarptosFestival(epoch: epoch)
        } else {
            return HarptosDate(epoch: epoch)
        }
    }
}

// MARK: - Retrieve human-readable names for years, months & festivals

extension HarptosCalendar {
    public static func getNameFor(year: Int) -> String? {
        return Calendar.getNameFor(year: year)
    }
    
    public static func getNamesFor(month: Int) -> [String] {
        let segment = InstantSegment(month: month)
        return [segment.name] + segment.alternateNames
    }
    
    public static func getNameFor(festival: Festival) -> String {
        let segment = InstantSegment(festival: festival)
        return segment.name
    }
}
