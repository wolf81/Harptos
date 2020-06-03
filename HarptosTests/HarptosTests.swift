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

    func testMidwinter() {
        let festival1 = HarptosCalendar.getFestivalFor(year: 1200, festival: .midwinter)
        let instant = HarptosCalendar.getInstantFor(epoch: festival1.epoch)
        
        XCTAssert(instant.year == festival1.year)
        XCTAssert(instant is HarptosFestival)
        XCTAssert((instant as! HarptosFestival).festival == festival1.festival)
    }

    func testPositiveYearHammerToMidwinter() {
        let date1 = HarptosCalendar.getDateFor(year: 1200, month: 1, day: 30)
        let instant = date1.instantByAdding(days: 1)
        
        XCTAssert(instant is HarptosFestival)
        XCTAssert(instant.year == date1.year)
        XCTAssert((instant as! HarptosFestival).festival == .midwinter)
    }
    
    func testNegativeYearHammerToMidwinter() {
        let date1 = HarptosCalendar.getDateFor(year: -1433, month: 1, day: 30)
        let instant = date1.instantByAdding(days: 1)
        
        XCTAssert(instant is HarptosFestival)
        XCTAssert(instant.year == date1.year)
        XCTAssert((instant as! HarptosFestival).festival == .midwinter)
    }
    
    func testTransitionFromMidsummerToShieldmeetInLeapYears() {
        let date1 = HarptosCalendar.getFestivalFor(year: 400, festival: .midsummer)
        let instant = date1.instantByAdding(days: 1)
        
        XCTAssert(instant is HarptosFestival)
        XCTAssert(instant.year == date1.year)
        XCTAssert((instant as! HarptosFestival).festival == .shieldmeet)
    }
    
    func testTransitionFromMidsummerToEleasis() {
        let date1 = HarptosCalendar.getFestivalFor(year: 401, festival: .midsummer)
        let instant = date1.instantByAdding(days: 1)
        
        XCTAssert(instant is HarptosDate)
        XCTAssert(instant.year == date1.year)
        XCTAssert((instant as! HarptosDate).month == 8)
    }

    func testTransitionFromMidsummerToFlamerule() {
        let date1 = HarptosCalendar.getFestivalFor(year: 401, festival: .midsummer)
        let instant = date1.instantByAdding(days: -1)
        
        XCTAssert(instant is HarptosDate)
        XCTAssert(instant.year == date1.year)
        XCTAssert((instant as! HarptosDate).month == 7)
    }

    func testPositiveTransitionToNextYear() {
        let date1 = HarptosCalendar.getDateFor(year: 533, month: 12, day: 30)
        let instant = date1.instantByAdding(days: 1)
        
        XCTAssert(date1.year + 1 == instant.year)
    }

    func testNegativeDateInLeapYear4() {
        let year = -48, month = 5, day = 12
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate
        
        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testNegativeDateInLeapYear() {
        let year = -48, month = 9, day = 12
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testNegativeDateBeforeLeapYear() {
        let year = -2, month = 11, day = 1
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }
    
    func testNegativeDateAfterLeapYear() {
        let year = -50, month = 3, day = 30
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }
    
    func testPositiveDateBeforeLeapYear() {
        let year = 1, month = 11, day = 15
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testX() {
        let year = 1454, month = 1, day = 30
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)

        print("date1: \(date1)")
        XCTAssert(date1.year == year)
        XCTAssert(date1.month == month)
        XCTAssert(date1.day == day)
    }
    
    func testPositiveDateAfterLeapYear6() {
        let year = 1454, month = 1, day = 30
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateAfterLeapYear2() {
        let year = 1454, month = 4, day = 15
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateAfterLeapYear4() {
        let year = 1600, month = 9, day = 21
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }
    
    func testPositiveDateAfterLeapYear5() {
        let year = 1733, month = 12, day = 19
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateAfterLeapYear3() {
        let year = 1454, month = 12, day = 15
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateAfterLeapYear() {
        let year = 6, month = 12, day = 15
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateAfterLeapYear7() {
        let year = -1434, month = 1, day = 2
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

        XCTAssert(date2.year == year)
        XCTAssert(date2.month == month)
        XCTAssert(date2.day == day)
    }

    func testPositiveDateInLeapYear() {
        let year = 4, month = 5, day = 12
        let date1 = HarptosCalendar.getDateFor(year: year, month: month, day: day)
        let date2 = HarptosCalendar.getInstantFor(epoch: date1.epoch) as! HarptosDate

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
