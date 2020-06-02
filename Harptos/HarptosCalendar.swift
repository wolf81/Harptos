//
//  Calendar.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosCalendar {    
    public static func getDateFor(epoch: Int) -> HarptosDate {
        // TODO:
        // day 31 of several months are in fact a holiday
        // day 32 of 7th month is holiday in leap year
        return HarptosDate(epoch: epoch)
    }

    public static func getNameFor(year: Int) -> String? {
        return Calendar.getNameFor(year: year)
    }
    
    public static func getNamesFor(month: Int) -> [String] {
        let month = HarptosYearSegment(rawValue: month)!
        return [month.name] + month.alternateNames
    }
    
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
    
    public static func getInstant(epoch: Int) -> HarptosInstant {
        let components = Calendar.getDateComponentsFor(epoch: epoch)
        if components.segment.isFestival {
            return HarptosFestival(epoch: epoch)
        } else {
            return HarptosDate(epoch: epoch)
        }
    }
}


/*
 a map of: [month][week][[day]
months: _map(months, month => ({
  ...month,
  weeks: _times(3, week => ({
    id: week,
    days: _times(10, day => ({
      id: day+(week*10)+1,
    })),
  })),
})),
*/
