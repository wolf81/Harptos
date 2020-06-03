//
//  Calendar.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosCalendar {
    public static func getDateFor(year: Int, month: Int, day: Int) -> HarptosDate {
        assert((1 ... 12).contains(month))
        assert((1 ... 30).contains(day))
                
        let segment = HarptosYearSegment.getSegmentIndexFor(month: month)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: day)
        return HarptosDate(epoch: epoch)
    }
    
    public static func getFestivalFor(year: Int, festival: Festival) -> HarptosFestival {
        let segment = HarptosYearSegment.getSegmentIndexFor(festival: festival)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: 1)
        return HarptosFestival(epoch: epoch)
    }
    
    public static func getInstant(epoch: Int) -> HarptosInstantProtocol {
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
        let segment = HarptosYearSegment(month: month)
        return [segment.name] + segment.alternateNames
    }
    
    public static func getNameFor(festival: Festival) -> String {
        let segment = HarptosYearSegment(festival: festival)
        return segment.name
    }
}
