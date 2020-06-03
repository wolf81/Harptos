//
//  HarptosDate.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// A HarptosDate represents a date on the Harptos calendar
public final class HarptosDate: HarptosInstant {
    
    /// The month
    public var month: Int { self.components.segment.month }
        
    /// The day
    public var day: Int { self.components.day }    
}

// MARK: - CustomStringConvertible

extension HarptosDate: CustomStringConvertible {
    public var description: String {
        return "\(components.year) \(components.segment.month) \(components.day) \(components.hour):\(components.minute):\(components.second)"
    }
}
