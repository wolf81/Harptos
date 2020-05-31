//
//  Calendar.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

enum Month: Int {
    case hammer
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
    
    var name: String {
        return String(describing: self).capitalized
    }
    
    var alternateNames: [String] {
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

public class HarptosCalendar {    
    public static func getDate(day: Int, month: Int, year: Int) -> HarptosDate {
        let dayRange = 1 ... Constants.daysPerMonth
        let monthRange = 1 ... Constants.monthsPerYear
        
        assert(dayRange.contains(day))
        assert(monthRange.contains(month))
        
        let days = year * Constants.daysPerYear + (month - 1) * Constants.daysPerMonth + (day - 1)
        let seconds = days * Constants.secondsPerDay
        
        return HarptosDate(seconds: seconds)
    }
}
