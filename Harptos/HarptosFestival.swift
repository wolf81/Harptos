//
//  HarptosFestival.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosFestival: HarptosInstant {
    public let epoch: Int
    
    public var year: Int {
        return self.components.year
    }
    
    private lazy var components: HarptosDateComponents = {
        let c = Calendar.getDateComponentsFor(epoch: self.epoch)
        print("\(c.year), \(c.segment), \(c.day)")
        return c
    }()
    
    var festival: Festival {
        return self.components.segment.festival
    }
        
    init(epoch: Int) {
        self.epoch = epoch
    }
}

extension HarptosFestival: CustomStringConvertible {
    public var description: String {
        "\(components.segment.name) \(components.year)"
    }
}
