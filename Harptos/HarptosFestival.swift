//
//  HarptosFestival.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 03/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosFestival: HarptosInstant {
    public var festival: Festival { self.components.segment.festival }                
}

// MARK: - CustomStringConvertible

extension HarptosFestival: CustomStringConvertible {
    public var description: String {
        "\(components.segment.name) \(components.year)"
    }
}
