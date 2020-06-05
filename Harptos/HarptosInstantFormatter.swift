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
        PatternFormatter(pattern: "YYYY", formatter: { "\($0.year)" }),
        PatternFormatter(pattern: "Y", formatter: { HarptosCalendar.getNameFor(year: $0.year) ?? "\($0.year)" }),
        PatternFormatter(pattern: "dd", formatter: { "\(($0 as! HarptosDate).day)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "d", formatter: { "\(($0 as! HarptosDate).day)" }),
        PatternFormatter(pattern: "MMM", formatter: { getLongNameForSegment(in: $0) }),
        PatternFormatter(pattern: "MM", formatter: { getShortNameForSegment(in: $0, isZeroPadded: true) }),
        PatternFormatter(pattern: "M", formatter: { getShortNameForSegment(in: $0, isZeroPadded: false) }),
        PatternFormatter(pattern: "hh", formatter: { "\($0.hour)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "h", formatter: { "\($0.hour)" }),
        PatternFormatter(pattern: "mm", formatter: { "\($0.minute)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "m", formatter: { "\($0.minute)" }),
        PatternFormatter(pattern: "ss", formatter: { "\($0.second)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "s", formatter: { "\($0.second)" }),
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
        
        return HarptosInstantFormatter.formatInstant(instant, formatString: formatString)
    }
    
    // MARK: - Private
    
    private static func formatInstant(_ instant: HarptosInstant, formatString string: String) -> String {
        guard let tree = generateTreeFrom(formatString: string as NSString, applyingInstant: instant) else { return "" }
        return generateStringFrom(node: tree)
    }
    
    private static func generateStringFrom(node: TreeNode) -> String {
        var result: String = node.value as String
        
        if let leftChild = node.leftChild {
            let prefix = generateStringFrom(node: leftChild)
            result = prefix.appending(result)
        }
        
        if let rightChild = node.rightChild {
            let suffix = generateStringFrom(node: rightChild)
            result = result.appending(suffix)
        }
        
        return result
    }
        
    /// Process a string, generating a binary tree for which the patterns will already be replaced with the appropriate values
    /// - Parameters:
    ///   - formatString: The format string to process
    ///   - instant: The HarptosInstant to use with the format string
    private static func generateTreeFrom(formatString: NSString, applyingInstant instant: HarptosInstant) -> TreeNode? {
        let regex = try! NSRegularExpression(pattern: "'.*?'")
        if let match = regex.matches(in: formatString as String, options: [], range: NSRange(location: 0, length: formatString.length)).first {
            let (leftNode, rightNode) = getChildNodesFor(formatString: formatString, applyingInstant: instant, inRange: match.range)
            let value = formatString.substring(with: match.range).replacingOccurrences(of: "'", with: "")
            return TreeNode(value as NSString, leftNode, rightNode)
        } else {
            for formatter in self.formatters {
                let range = formatString.range(of: formatter.pattern)
                guard range.location != NSNotFound else { continue }

                let (leftNode, rightNode) = getChildNodesFor(formatString: formatString, applyingInstant: instant, inRange: range)
                let value = formatter.apply(instant: instant)
                return TreeNode(value as NSString, leftNode, rightNode)
            }
        }
        
        return TreeNode(formatString, nil, nil)
    }
        
    /// Get child nodes for a given format string, based on a dividing range, i.e. assuming a range
    /// of (5 ... 9), a string length of 14 chars, we'll get a left node for range (0 ... 4) and a
    /// right node for range (10 ... 14)
    ///   - string: The format string to process
    ///   - instant: The HarptosInstant to apply when formatting nodes
    ///   - range: A range that acts as divider for the left and right nodes
    private static func getChildNodesFor(formatString: NSString, applyingInstant instant: HarptosInstant, inRange range: NSRange) -> (left: TreeNode?, right: TreeNode?) {
        var prefix: String?
        var suffix: String?
        
        if range.location > 0 {
            let prefixRange = NSMakeRange(0, range.location)
            prefix = formatString.substring(with: prefixRange)
        }
        
        let suffixStartIndex = range.location + range.length
        if suffixStartIndex < formatString.length {
            let suffixRange =  NSMakeRange(suffixStartIndex, formatString.length - suffixStartIndex)
            suffix = formatString.substring(with: suffixRange)
        }
        
        var leftNode: TreeNode?
        if prefix != nil {
            leftNode = generateTreeFrom(formatString: prefix! as NSString, applyingInstant: instant)
        }

        var rightNode: TreeNode?
        if suffix != nil {
            rightNode = generateTreeFrom(formatString: suffix! as NSString, applyingInstant: instant)
        }
        
        return (leftNode, rightNode)
    }
            
    /// Return the long name for a given segment; for a festival always the festival name, for a
    /// month the most common month name.
    /// - Parameter instant: The HarptosInstant for which we want to get the segment long name
    private static func getLongNameForSegment(in instant: HarptosInstantProtocol) -> String {
        switch instant {
        case let date as HarptosDate:
            return HarptosCalendar.getNamesFor(month: date.month).first!
        case let festival as HarptosFestival:
            return HarptosCalendar.getNameFor(festival: festival.festival)
        default: fatalError()
        }
    }
     
    /// Return the short name for a given segment; for a festival there is no short name, but for
    /// a month this would be the numeric string, i.e.: "1" for Hammer
    /// - Parameters:
    /// - Parameter instant: The HarptosInstant for which we want to get the segment short name
    /// - isZeroPadded: Set to true if wanting to add padding zeroes
    private static func getShortNameForSegment(in instant: HarptosInstant, isZeroPadded: Bool) -> String {
        switch instant {
        case let date as HarptosDate:
            return isZeroPadded ? "\(date.month)".padLeft(totalWidth: 2, with: "0") : "\(date.month)"
        case let festival as HarptosFestival:
            return HarptosCalendar.getNameFor(festival: festival.festival)
        default: fatalError()
        }
    }
        
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
    
    private class TreeNode {
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
