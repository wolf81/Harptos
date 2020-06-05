//
//  TimeComponents.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 02/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

struct TimeComponents {
    var year: Int
    
    /// A segment either be a month or festival
    var segment: YearTimeSegment
    var month: Int? { self.segment.month }
    var festival: HarptosFestival { self.segment.festival }

    var day: Int
    
    var hour: Int
    
    var minute: Int
    
    var second: Int
}
