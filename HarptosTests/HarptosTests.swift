//
//  HarptosTests.swift
//  HarptosTests
//
//  Created by Wolfgang Schreurs on 31/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import XCTest
@testable import Harptos

class HarptosTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNegativeDateInLeapYear() {
        let year = -48, month = 9, day = 12
        let date1 = HarptosDate(year: year, month: month, day: day)
        let date2 = HarptosDate(epoch: date1.epoch)
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testNegativeDateBeforeLeapYear() {
        let year = -2, month = 11, day = 1
        let date1 = HarptosDate(year: year, month: month, day: day)
        let date2 = HarptosDate(epoch: date1.epoch)
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    
    func testNegativeDateAfterLeapYear() {
        let year = -50, month = 3, day = 1
        let date1 = HarptosDate(year: year, month: month, day: day)
        let date2 = HarptosDate(epoch: date1.epoch)
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }
    
    func testPositiveDateBeforeLeapYear() {
        let year = 1, month = 11, day = 15
        let date1 = HarptosDate(year: year, month: month, day: day)
        let date2 = HarptosDate(epoch: date1.epoch)
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }
    
    func testPositiveDateAfterLeapYear() {
        let year = 6, month = 11, day = 15
        let date1 = HarptosDate(year: year, month: month, day: day)
        let date2 = HarptosDate(epoch: date1.epoch)
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateInLeapYear() {
        let year = 4, month = 5, day = 12
        let date1 = HarptosDate(year: year, month: month, day: day)
        let date2 = HarptosDate(epoch: date1.epoch)
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
