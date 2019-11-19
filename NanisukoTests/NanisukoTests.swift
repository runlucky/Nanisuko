//
//  NanisukoTests.swift
//  NanisukoTests
//
//  Created by 福田走 on 2019/11/19.
//  Copyright © 2019 福田走. All rights reserved.
//

import XCTest
@testable import Nanisuko

class NanisukoTests: XCTestCase {

    func testはちすこ()      { "はちすこ".toDate().is(date(20, 0)) }
    func test8時半すこ()     { "8時半すこ".toDate().is(date(20, 30)) }
    func testおそすこ()      { "おそすこ".toDate().is(date(21, 0)) }
    func testはやすこ()      { "はやすこ".toDate().is(date(19, 30)) }
    func test７時すこ()      { "７時すこ".toDate().is(date(19, 0)) }
    func test18時半すこ()    { "18時半すこ".toDate().is(date(18, 30)) }
    func test定時すこ()      { "定時すこ".toDate().is(date(19, 0)) }
    func testはちじはんすこ() { "はちじはんすこ".toDate().is(date(20, 30)) }

    
    func date(_ hour: Int?, _ minute: Int?) -> Date {
        var component = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        component.hour = hour
        component.minute = minute

        guard let time = Calendar.current.date(from: component) else {
            XCTFail()
            fatalError()
        }
        return time
    }
}
