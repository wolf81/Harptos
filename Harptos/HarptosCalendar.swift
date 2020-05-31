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
        let (year, month, day) = Calendar.getDateComponentsFor(epoch: epoch)
        return HarptosDate(year: year, month: month, day: day)
    }

    public static func getNameFor(year: Int) -> String? {
        return Calendar.getNameFor(year: year)
    }
    
    public static func getNamesFor(month: Int) -> [String] {
        let month = Month(rawValue: month)!
        return [month.name] + month.alternateNames
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
