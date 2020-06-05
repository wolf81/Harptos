//
//  StringExtensions.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 05/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

internal extension String {
    func padLeft(totalWidth: Int, with paddingString: String) -> String {
        let toPad = totalWidth - self.count
        
        guard toPad > 0 else { return self }
        
        return String().padding(toLength: toPad, withPad: paddingString, startingAt: 0) + self
    }
}
