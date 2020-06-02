//
//  Month.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

enum Month: Int, CaseIterable {
    case hammer = 1
    case alturiak
    case ches
    case tarsakh
    case mirtul
    case kythorn
    case flamerule
    case eleasis
    case eleint
    case marpenoth
    case uktar
    case nightal
    
    var holiday: Holiday? {
        switch self {
        case .hammer: return .midwinter
        case .tarsakh: return .greengrass
        case .flamerule: return .midsummer
        case .eleint: return .highharvestide
        case .uktar: return .moonfeast
        default: return nil
        }
    }
    
    public var index: Int {
        return self.rawValue
    }
    
    public var name: String {
        return String(describing: self).capitalized
    }
    
    public var alternateNames: [String] {
        switch self {
        case .hammer: return ["Deepwinter"]
        case .alturiak: return ["The Claw of Winter", "The Claws of the Cold"]
        case .ches: return ["The Claw of Sunsets"]
        case .tarsakh: return ["The Claw of Storms"]
        case .mirtul: return ["The Melting"]
        case .kythorn: return ["The Time of Flowers"]
        case .flamerule: return ["Summertide"]
        case .eleasis: return ["Highsun"]
        case .eleint: return ["The Fading"]
        case .marpenoth: return ["Leaffall"]
        case .uktar: return ["The Rotting"]
        case .nightal: return ["The Drawing Down"]
        }
    }
}
