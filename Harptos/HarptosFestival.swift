//
//  HarptosFestival.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosFestival: HarptosInstant {
    let epoch: Int
    
    private lazy var components: HarptosDateComponents = {
        let c = Calendar.getDateComponentsFor(epoch: self.epoch)
        print("\(c.year), \(c.segment), \(c.day)")
        return c
    }()
    
    var festival: Festival {
        return self.components.segment.festival
    }
    
    public required init(epoch: Int) {
        self.epoch = epoch
    }
    
    public convenience init(year: Int, festival: Festival) {
        let segment = HarptosYearSegment.getSegmentIndex(for: festival)
        let epoch = Calendar.getEpochFor(year: year, segment: segment, day: 1)
        self.init(epoch: epoch)
    }
}

extension HarptosFestival: CustomStringConvertible {
    public var description: String {
        "\(components.segment.name) \(components.year)"
    }
}
