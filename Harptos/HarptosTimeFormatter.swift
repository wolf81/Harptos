//
//  HarptosTimeFormatter.swift
//  Harptos
//
//  Created by Wolfgang Schreurs on 04/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// Use the `HarptosTimeFormatter` to format instances of `HarptosTime`, the following patterns can
/// be used:
/// - YYYY: the year, e.g.: 909
/// - Y: the long name of the year, e.g.: "The Year of the Ogre" for 909 DR
/// - M: the month number, through 1 - 12
/// - MM: the month number, through 01 - 12
/// - MMM: the full of the month / festival, e.g.: Tarsakh for the 4th Month or Midwinter for the festival the day after Hammer 30
/// - dd: the day of the month, through 01 - 30
/// - d: the day of the month, though 1 - 30
/// - hh: the hour, through 00 - 23
/// - h: the hour, through 0 - 23
/// - mm: the minute, through 00 - 59
/// - m: the minute, through 0 - 59
/// - ss: the second, through 00 - 59
/// - s: the second, through 0 - 59
public class HarptosTimeFormatter {
    
    /// The format string to be used for months
    let monthFormat: String
    
    /// The format string to be used for festivals
    let festivalFormat: String
    
    private static var formatters: [PatternFormatter] = [
        PatternFormatter(pattern: "YYYY", formatter: { "\($0.year)" }),
        PatternFormatter(pattern: "Y", formatter: { HarptosCalendar.getNameFor(year: $0.year) ?? "\($0.year)" }),
        PatternFormatter(pattern: "dd", formatter: { "\($0.day)".padLeft(totalWidth: 2, with: "0") }),
        PatternFormatter(pattern: "d", formatter: { "\($0.day)" }),
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
            
    /// The constructor
    /// - Parameters:
    ///   - monthFormat: A format string for months
    ///   - festivalFormat: A format string for festivals
    public init(monthFormat: String, festivalFormat: String) {
        self.monthFormat = monthFormat
        self.festivalFormat = festivalFormat
    }
        
    /// Return a formatted string for a given `HarptosTime`
    /// - Parameter time: The time to be formatted
    public func string(from time: HarptosTime) -> String {
        let formatString = time.components.segment.isMonth ? self.monthFormat : self.festivalFormat
        return HarptosTimeFormatter.formatTime(time, usingFormatString: formatString)
    }

    // MARK: - Private
    
    private static func formatTime(_ time: HarptosTime, usingFormatString string: String) -> String {
        guard let tree = generateTreeFrom(formatString: string as NSString, applyingTime: time) else { return "" }
        return generateStringFrom(node: tree)
    }
    
    /// Generate a string from the tree by combining string values in child nodes with the string value in the parent node
    /// - Parameter node: A node in the tree
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
    ///   - time: The `HarptosTime` to use with the format string
    private static func generateTreeFrom(formatString: NSString, applyingTime time: HarptosTime) -> TreeNode? {
        // ignore content between single quotes
        let excludedTextRegex = try! NSRegularExpression(pattern: "'.*?'")
        if let match = excludedTextRegex.matches(in: formatString as String, options: [], range: NSRange(location: 0, length: formatString.length)).first {
            let (leftNode, rightNode) = getChildNodesFor(formatString: formatString, applyingTime: time, inRange: match.range)
            let value = formatString.substring(with: match.range).replacingOccurrences(of: "'", with: "")
            return TreeNode(value as NSString, leftNode, rightNode)
        } else {
            for formatter in self.formatters {
                let range = formatString.range(of: formatter.pattern)
                guard range.location != NSNotFound else { continue }

                let (leftNode, rightNode) = getChildNodesFor(formatString: formatString, applyingTime: time, inRange: range)
                let value = formatter.apply(time: time)
                return TreeNode(value as NSString, leftNode, rightNode)
            }
        }
        
        return TreeNode(formatString, nil, nil)
    }
        
    /// Get child nodes for a given format string, based on a dividing range, i.e. assuming a range
    /// of (5 ... 9), a string length of 14 chars, we'll get a left node for range (0 ... 4) and a
    /// right node for range (10 ... 14)
    ///   - string: The format string to process
    ///   - time: The `HarptosTime` to apply when formatting nodes
    ///   - range: A range that acts as divider for the left and right nodes
    private static func getChildNodesFor(formatString: NSString, applyingTime time: HarptosTime, inRange range: NSRange) -> (left: TreeNode?, right: TreeNode?) {
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
            leftNode = generateTreeFrom(formatString: prefix! as NSString, applyingTime: time)
        }

        var rightNode: TreeNode?
        if suffix != nil {
            rightNode = generateTreeFrom(formatString: suffix! as NSString, applyingTime: time)
        }
        
        return (leftNode, rightNode)
    }
            
    /// Return the long name for a given segment; for a festival always the festival name, for a
    /// month the most common month name.
    /// - Parameter time: The `HarptosTime` for which we want to get the segment long name
    private static func getLongNameForSegment(in time: HarptosTime) -> String {
        if time.components.segment.isMonth {
            return HarptosCalendar.getNamesFor(month: time.components.segment.month).first!
        } else {
            return HarptosCalendar.getNameFor(festival: time.components.segment.festival)
        }
    }
     
    /// Return the short name for a given segment; for a festival there is no short name, but for
    /// a month this would be the numeric string, i.e.: "1" for Hammer
    /// - Parameters:
    /// - Parameter time: The `HarptosTime` for which we want to get the segment short name
    /// - isZeroPadded: Set to true if wanting to add padding zeroes
    private static func getShortNameForSegment(in time: HarptosTime, isZeroPadded: Bool) -> String {
        if time.components.segment.isMonth {
            return (isZeroPadded
                ? "\(time.components.segment.month)".padLeft(totalWidth: 2, with: "0")
                : "\(time.components.segment.month)")
        } else {
            return HarptosCalendar.getNameFor(festival: time.components.segment.festival)
        }
    }
            
    /// A class that combines a pattern with a formatting function, the formatting function can be
    /// executed at some point by calling `apply(time: ...)`
    private class PatternFormatter {
        let pattern: String
        let formatter: (HarptosTime) -> String
        
        init(pattern: String, formatter: @escaping (HarptosTime) -> String) {
            self.pattern = pattern
            self.formatter = formatter
        }
        
        func apply(time: HarptosTime) -> String {
            return self.formatter(time)
        }
    }
        
    /// A binary tree node, used for formatting the time objects
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
