//
//  HarptosFestival.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// Festivals as defined by the Harptos calendar
public enum Festival: Int {
    case midwinter
    case greengrass
    case midsummer
    case highharvestide
    case moonfeast
    case shieldmeet
}

/// A HarptosFestival represents a festival in a given year on the Harptos calendar
public final class HarptosFestival: HarptosInstant {
    
    /// The festival
    public var festival: Festival { self.components.segment.festival }                
}

// MARK: - CustomStringConvertible

extension HarptosFestival: CustomStringConvertible {
    public var description: String {
        "\(components.segment.name) \(components.year)"
    }
}
