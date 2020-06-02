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
    case midwinter // holiday
    case alturiak
    case ches
    case tarsakh
    case greengrass // holiday
    case mirtul
    case kythorn
    case flamerule
    case midsummer // holiday
    case eleasis
    case eleint
    case highharvestide // holiday
    case marpenoth
    case uktar
    case moonfeast // holiday
    case nightal
    
    var isHoliday: Bool {
        return [.midwinter, .greengrass, .midsummer, .highharvestide, .moonfeast].contains(self)
    }

    static func getInternalIndex(for holiday: Holiday) -> Int {
        switch holiday {
        case .midwinter: return 2
        case .greengrass: return 6
        case .midsummer: return 10
        case .highharvestide: return 13
        case .moonfeast: return 16
        case .shieldmeet: fatalError()
        }
    }
    
    static func getInternalIndex(for index: Int) -> Int {
        switch index {
        case 1: return 1
        case 2: return 3
        case 3: return 4
        case 4: return 5
        case 5: return 7
        case 6: return 8
        case 7: return 9
        case 8: return 11
        case 9: return 12
        case 10: return 14
        case 11: return 15
        case 12: return 17
        default: fatalError()
        }
    }
    
    var holiday: Holiday? {
        switch self {
        case .midwinter: return Holiday.midwinter
        case .midsummer: return Holiday.midsummer
        case .greengrass: return Holiday.greengrass
        case .highharvestide: return Holiday.highharvestide
        case .moonfeast: return Holiday.moonfeast
        default: return nil
        }
    }
    
    public var index: Int {
        switch self.rawValue {
        case 1: return 1
        case 3: return 2
        case 4: return 3
        case 5: return 4
        case 7: return 5
        case 8: return 6
        case 9: return 7
        case 11: return 8
        case 12: return 9
        case 14: return 10
        case 15: return 11
        case 17: return 12
        default: fatalError()
        }
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
        default: return []
        }
    }
}
