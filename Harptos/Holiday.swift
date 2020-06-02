//
//  Holiday.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosHoliday {
    
}

public enum Holiday: Int {
    case midwinter
    case greengrass
    case midsummer
    case highharvestide
    case moonfeast
    case shieldmeet
    
    var name: String {
        switch self {
        case .moonfeast: return "Feast of the Moon"
        default: return String(describing: self).capitalized
        }
    }
}
