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
    
    func testDateFormatter() {
        let formatter = HarptosTimeFormatter(monthFormat: "dd M YYYY 'DR Y mm' YYYY", festivalFormat: "M Y")
        let time = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 30, hour: 1, minute: 5, second: 2)
        let string = formatter.string(from: time)
        
        print(time)        
        print(string)
    }

    func testFestivalFormatter() {
        let formatter = HarptosTimeFormatter(monthFormat: "dd M YYYY", festivalFormat: "M, Y - hh:mm:ss")
        let time = HarptosCalendar.getTimeFor(year: 1244, festival: .greengrass, hour: 13, minute: 32, second: 2)
        let string = formatter.string(from: time)
        
        print(string)
    }

    func testModifyTime() {
        let time1 = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 30, hour: 1, minute: 5, second: 2)
        let time = time1
            .timeByAdding(hours: 2)
            .timeByAdding(minutes: 6)
            .timeByAdding(seconds: 5)
                
        XCTAssert(time.hour == 3)
        XCTAssert(time.minute == 11)
        XCTAssert(time.second == 7)
    }
    
    func testTime() {
        let time1 = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 30, hour: 1, minute: 5, second: 2)

        XCTAssert(time1.year == 1200)
        XCTAssert(time1.month != nil && time1.month! == 1)
        XCTAssert(time1.day == 30)
        XCTAssert(time1.hour == 1)
        XCTAssert(time1.minute == 5)
        XCTAssert(time1.second == 2)
    }
    
    func testMidwinter() {
        let festival1 = HarptosCalendar.getTimeFor(year: 1200, festival: .midwinter)
        let time = HarptosCalendar.getTimeFor(epoch: festival1.epoch)
        
        XCTAssert(time.year == festival1.year)
        XCTAssert(time.festival == festival1.festival)
    }

    func testPositiveYearHammerToMidwinter() {
        let time1 = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 30)
        let time = time1.timeByAdding(days: 1)
        
        XCTAssert(time.year == time1.year)
        XCTAssert(time.festival == .midwinter)
    }
    
    func testNegativeYearHammerToMidwinter() {
        let time1 = HarptosCalendar.getTimeFor(year: -1433, month: 1, day: 30)
        let time = time1.timeByAdding(days: 1)
        
        XCTAssert(time.year == time1.year)
        XCTAssert(time.festival == .midwinter)
    }
    
    func testTransitionFromMidsummerToShieldmeetInLeapYears() {
        let time1 = HarptosCalendar.getTimeFor(year: 400, festival: .midsummer)
        let time = time1.timeByAdding(days: 1)
        
        XCTAssert(time.year == time1.year)
        XCTAssert(time.festival == .shieldmeet)
    }
    
    func testTransitionFromMidsummerToEleasis() {
        let time1 = HarptosCalendar.getTimeFor(year: 401, festival: .midsummer)
        let time = time1.timeByAdding(days: 1)
        
        XCTAssert(time.year == time1.year)
        XCTAssert(time.month == 8)
    }

    func testTransitionFromMidsummerToFlamerule() {
        let time1 = HarptosCalendar.getTimeFor(year: 401, festival: .midsummer)
        let time = time1.timeByAdding(days: -1)
        
        XCTAssert(time.year == time1.year)
        XCTAssert(time.month == 7)
    }

    func testPositiveTransitionToNextYear() {
        let time1 = HarptosCalendar.getTimeFor(year: 533, month: 12, day: 30)
        let time2 = time1.timeByAdding(days: 1)
        
        XCTAssert(time1.year + 1 == time2.year)
    }

    func testNegativeDateInLeapYear4() {
        let year = -48, month = 5, day = 12
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)
        
        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testNegativeDateInLeapYear() {
        let year = -48, month = 9, day = 12
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testNegativeDateBeforeLeapYear() {
        let year = -2, month = 11, day = 1
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }
    
    func testNegativeDateAfterLeapYear() {
        let year = -50, month = 3, day = 30
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }
    
    func testPositiveDateBeforeLeapYear() {
        let year = 1, month = 11, day = 15
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }
    
    func testPositiveDateAfterLeapYear6() {
        let year = 1454, month = 1, day = 30
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testPositiveDateAfterLeapYear2() {
        let year = 1454, month = 4, day = 15
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch) 

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testPositiveDateAfterLeapYear4() {
        let year = 1600, month = 9, day = 21
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }
    
    func testPositiveDateAfterLeapYear5() {
        let year = 1733, month = 12, day = 19
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testPositiveDateAfterLeapYear3() {
        let year = 1454, month = 12, day = 15
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testPositiveDateAfterLeapYear() {
        let year = 6, month = 12, day = 15
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testPositiveDateAfterLeapYear7() {
        let year = -1434, month = 1, day = 2
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

    func testPositiveDateInLeapYear() {
        let year = 4, month = 5, day = 12
        let time1 = HarptosCalendar.getTimeFor(year: year, month: month, day: day)
        let time2 = HarptosCalendar.getTimeFor(epoch: time1.epoch)

        XCTAssert(time2.year == year)
        XCTAssert(time2.month == month)
        XCTAssert(time2.day == day)
    }

//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
