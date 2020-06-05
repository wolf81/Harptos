//
//  HarptosInstantFormatter.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 04/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class HarptosInstantFormatter {
    let dateFormat: String
    let festivalFormat: String
    
    private static var formatters: [PatternFormatter] = [
        PatternFormatter(pattern: "yyyy", formatter: { "\($0.year)" }),
        PatternFormatter(pattern: "Y", formatter: { HarptosCalendar.getNameFor(year: $0.year) ?? "\($0.year)" }),
        PatternFormatter(pattern: "dd", formatter: { "\(($0 as! HarptosDate).day)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "d", formatter: { "\(($0 as! HarptosDate).day)" }),
        PatternFormatter(pattern: "M", formatter: { HarptosCalendar.getNamesFor(month: ($0 as! HarptosDate).month).first! }),
        PatternFormatter(pattern: "mm", formatter: { "\(($0 as! HarptosDate).month)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "m", formatter: { "\(($0 as! HarptosDate).month)" }),
        PatternFormatter(pattern: "F", formatter: { HarptosCalendar.getNameFor(festival: ($0 as! HarptosFestival).festival) }),
    ]
        
    public init(dateFormat: String, festivalFormat: String) {
        self.dateFormat = dateFormat
        self.festivalFormat = festivalFormat
    }
    
    public func string(from instant: HarptosInstant) -> String {
        var formatString = ""
        
        switch instant {
        case _ as HarptosDate: formatString = self.dateFormat
        case _ as HarptosFestival: formatString = self.festivalFormat
        default: fatalError()
        }
        
        let formattedString = HarptosInstantFormatter.formatInstant(instant, formatString: formatString)

        return formattedString

        // perhaps:
        // process each pattern
        //  if pattern not in

        /*
        let regex = try! NSRegularExpression(pattern: "'.*?'")
        var startIndex = 0
        while true {
            let range = NSRange(location: 0, length: string.length)
            guard let match = regex.matches(in: self.dateFormat, options: [], range: range).first else { break }
            print("match: \(match.range.location) \(match.range.length)")
            let matchedRange = NSRange(location: match.range.location, length: match.range.length)

            
            
            string = string.replacingCharacters(in: matchedRange, with: "") as NSString
            startIndex = matchedRange.location + matchedRange.length
//            string.re
        }*/
        
                
//        for formatter in self.formatters {
////            print("process: \(formatter.pattern)")
//
//            while true {
//                let range = string.range(of: formatter.pattern)
//                guard range.location != NSNotFound else { break }
//
//                formatter.apply(instant: instant, toString: &string, inRange: range)
//            }
//        }
    }
    
    static func formatInstant(_ instant: HarptosInstant, formatString string: String) -> String {
        var result = ""
        
        if let tree = process(string: string as NSString, instant: instant) {
            result = merge(node: tree)
        }

        return result
    }
    
    static func merge(node: TreeNode) -> String {
        var result: String = node.value as String
        
        if let leftChild = node.leftChild {
            let prefix = merge(node: leftChild)
            result = prefix.appending(result)
        }
        
        if let rightChild = node.rightChild {
            let suffix = merge(node: rightChild)
            result = result.appending(suffix)
        }
        
        return result
    }
    
    static func process(string: NSString, instant: HarptosInstant) -> TreeNode? {
        print("process: \(string)")
        
        for formatter in self.formatters {
            let range = string.range(of: formatter.pattern)
            if range.location != NSNotFound {
                let astring = string.substring(with: range)
                var prefix: String?
                var suffix: String?
                
                if range.location > 0 {
                    let prefixRange = NSMakeRange(0, range.location)
                    prefix = string.substring(with: prefixRange)
                }
                
                let suffixStartIndex = range.location + range.length
                if suffixStartIndex < string.length {
                    let suffixRange =  NSMakeRange(suffixStartIndex, string.length - suffixStartIndex)
                    suffix = string.substring(with: suffixRange)
                }
                
                print("string: \(astring)")
                var leftNode: TreeNode?
                if prefix != nil {
                    print("left: \(prefix!)")
                    leftNode = process(string: prefix! as NSString, instant: instant)
                }

                var rightNode: TreeNode?
                if suffix != nil {
                    print("right: \(suffix!)")
                    rightNode = process(string: suffix! as NSString, instant: instant)
                }
                
                let value = formatter.apply(instant: instant)
                return TreeNode(value as NSString, leftNode, rightNode)
            }
        }
        
        return TreeNode(string, nil, nil)
    }
        
    // MARK: - Private
    
    private class PatternFormatter {
        let pattern: String
        let formatter: (HarptosInstant) -> String
        
        init(pattern: String, formatter: @escaping (HarptosInstant) -> String) {
            self.pattern = pattern
            self.formatter = formatter
        }
        
        func apply(instant: HarptosInstant) -> String {
            return self.formatter(instant)
        }
    }
    
    class TreeNode {
        var value: NSString
        var leftChild: TreeNode?
        var rightChild: TreeNode?
        
        init(_ value: NSString,_ leftChild: TreeNode?,_ rightChild: TreeNode?) {
            self.value = value
            self.rightChild = rightChild
            self.leftChild = leftChild
        }
    }
}
