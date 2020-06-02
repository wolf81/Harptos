//
//  HarptosDate.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosDate: HarptosInstant {
    public let epoch: Int

    private lazy var components: HarptosDateComponents = {
        let c = Calendar.getDateComponentsFor(epoch: self.epoch)
        print("\(c.year), \(c.segment), \(c.day)")
        return c
    }()
    
    public var year: Int { return self.components.year }

    var month: Int { return self.components.segment.month }
    
    var day: Int { return self.components.day }
    
    init(epoch: Int) {
        self.epoch = epoch
    }        
}

extension HarptosDate: CustomStringConvertible {
    public var description: String {
        return "\(components.year) \(components.segment.month) \(components.day)"
    }
}
