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
    var segment: YearTimeSegment
    var day: Int
    var hour: Int
    var minute: Int
    var second: Int
    
    var month: Int? { self.segment.month }
    var festival: Festival { self.segment.festival }    
}
