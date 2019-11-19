//
//  SwiftChainingAssertion.swift
//  SwiftChainingAssertion
//
//  Created by 福田走 on 2019/04/10.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation
import XCTest

extension Equatable {
    public func `is`(_ value: Self) {
        XCTAssertEqual(self, value)
    }

    public func isNot(_ value: Self) {
        XCTAssertNotEqual(self, value)
    }

    public func `is`(_ predicate: () -> Self) {
        XCTAssertEqual(self, predicate())
    }

    public func isNot(_ predicate: () -> Self) {
        XCTAssertNotEqual(self, predicate())
    }
}

extension Optional {
    public func isNil() {
        XCTAssertNil(self)
    }

    public func isNotNil() {
        XCTAssertNotNil(self)
    }
}

public extension Array where Element: Equatable {
    public func isAll(_ predicate: (Element) -> Bool) {
        for x in self {
            predicate(x).isTrue()
        }
    }

    public func isNotAll(_ predicate: (Element) -> Bool) {
        for x in self {
            predicate(x).isFalse()
        }
    }
}

public extension Bool {
    public func isTrue() {
        XCTAssertTrue(self)
    }

    public func isFalse() {
        XCTAssertFalse(self)
    }
}
