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
    public static func getDateFor(year: Int, month: Int, day: Int) -> HarptosDate {
        assert((1 ... 12).contains(month))
        assert((1 ... 30).contains(day))
                
        let segment = InstantSegment.getSegmentIndexFor(month: month)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: day)
        return HarptosDate(epoch: epoch)
    }
        
    /// Return a HarptosFestival object for a given year and festival
    /// - Parameters:
    ///   - year: The year, it's recommended to limit the range from -700 DR to 1600 DR
    ///   - festival: A festival
    public static func getFestivalFor(year: Int, festival: Festival) -> HarptosFestival {
        let segment = InstantSegment.getSegmentIndexFor(festival: festival)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: 1)
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
