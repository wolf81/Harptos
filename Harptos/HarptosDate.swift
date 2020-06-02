//
//  HarptosDate.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

enum HarptosYearSegment {
    case month(Month)
    case holiday(Holiday)
}

public class HarptosDate {
    let epoch: Int

    private lazy var components: HarptosDateComponents = {
        let c = Calendar.getDateComponentsFor(epoch: self.epoch)
        print("\(c.year), \(c.month), \(c.day)")
        return c
    }()
    
    var year: Int { return self.components.year }

    var month: Int? {
        let month = self.components.month
        if month.isHoliday { return nil }
        return self.components.month.index
    }
    
    var day: Int { return self.components.day }

    var holiday: Holiday? { return self.components.month.holiday }
    
    public init(epoch: Int) {
        self.epoch = epoch
    }
    
    public init(year: Int, holiday: Holiday) {
        let monthIdx = Month.getInternalIndex(for: holiday)
        self.epoch = Calendar.getEpochFor(year: year, month: monthIdx, day: 1)
    }
    
    public init(year: Int, month: Int, day: Int) {
        assert(day <= 30)
        let monthIdx = Month.getInternalIndex(for: month)
        self.epoch = Calendar.getEpochFor(year: year, month: monthIdx, day: day)
    }
}

extension HarptosDate: CustomStringConvertible {
    public var description: String {
        if let holiday = self.holiday {
            return "\(self.year) \(holiday.name)"
        } else {
            return "\(self.year) \(self.month!) \(self.day)"
        }
    }
}
