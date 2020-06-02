//
//  HarptosDate.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosDate {
    let epoch: Int

    private lazy var components: HarptosDateComponents = {
        return Calendar.getDateComponentsFor(epoch: self.epoch)
    }()
    
    var year: Int { return self.components.year }
    
    var month: Int { return self.components.month.index }
    
    var day: Int { return self.components.day }
    
    public init(epoch: Int) {
        self.epoch = epoch
    }
    
    public init(year: Int, month: Int, day: Int) {
        print("\(year), \(month), \(day)")
        self.epoch = Calendar.getEpochFor(year: year, month: month, day: day)
    }
}

extension HarptosDate: CustomStringConvertible {
    public var description: String {
        return "\(self.year) \(self.month) \(self.day)"
    }
}
