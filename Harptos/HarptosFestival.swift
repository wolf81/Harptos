//
//  HarptosFestival.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 05/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// The festivals that occur on days between months on the Calendar of Harptos
/// - midwinter: occurs between months 1 and 2
/// - greengrass: occurs between months 4 and 5
/// - midsummer: occurs between months 7 and 8, followed by shieldmeet on leap years
/// - highharvestide: occurs between months 9 and 10
/// - moonfeast: occurs between months 11 and 12
/// - shieldmeet: in leap years occurs after midsummer and before month 8
public enum HarptosFestival: Int {
    case midwinter 
    case greengrass
    case midsummer
    case highharvestide
    case moonfeast
    case shieldmeet
}
