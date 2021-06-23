//
//  MoneyTest.swift
//  TDDSwiftTests
//
//  Created by gurrium on 2021/05/04.
//

import XCTest
@testable import TDDSwift

class MoneyTest: XCTestCase {
    func testSumTimes() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank = Bank()
        bank.addRate(2, from: "CHF", to: "USD")
        let sum: Expression = Sum(fiveBucks, tenFrancs).times(2)
        let result: Money = bank.reduce(sum, to: "USD")
        XCTAssertEqual(result, Money.dollar(amount: 20))
    }

    func testSumPlusMoney() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank = Bank()
        bank.addRate(2, from: "CHF", to: "USD")
        let sum: Expression = Sum(fiveBucks, tenFrancs).plus(fiveBucks)
        let result: Money = bank.reduce(sum, to: "USD")
        XCTAssertEqual(result, Money.dollar(amount: 15))
    }

    func testMixedAddition() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank = Bank()
        bank.addRate(2, from: "CHF", to: "USD")
        let result: Money = bank.reduce(fiveBucks.plus(tenFrancs), to: "USD")
        XCTAssertEqual(result, Money.dollar(amount: 10))
    }

    func testAddition() {
        let five: Money = Money.dollar(amount: 5)
        let sum: Expression = five.plus(five)
        let bank: Bank = Bank()
        let reduced: Money = bank.reduce(sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), reduced)
    }

    func testPlusReturnsSum() {
        let five: Money = Money.dollar(amount: 5)
        let result: Expression = five.plus(five)
        let sum: Sum = result as! Sum
        let bank = Bank()
        XCTAssertEqual(five, sum.augend.reduce(to: "USD", bank: bank))
        XCTAssertEqual(five, sum.addend.reduce(to: "USD", bank: bank))
    }

    func testReduceSum() {
        let sum: Expression = Sum(Money.dollar(amount: 4), Money.dollar(amount: 3))
        let bank = Bank()
        let result: Money = bank.reduce(sum, to: "USD")
        XCTAssertEqual(result, Money.dollar(amount: 7))
    }

    func testReduceMoney() {
        let bank = Bank()
        let result: Money = bank.reduce(Money.dollar(amount: 1), to: "USD")
        XCTAssertEqual(result, Money.dollar(amount: 1))
    }

    func testReduceMoneyDifferentCurrency() {
        let bank = Bank()
        bank.addRate(2, from: "CHF", to: "USD")
        let result: Money = bank.reduce(Money.franc(amount: 2), to: "USD")
        XCTAssertEqual(result, Money.dollar(amount: 1))
    }

    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        let bank = Bank()
        XCTAssertEqual(Money.dollar(amount: 10), five.times(2).reduce(to: "USD", bank: bank))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(3).reduce(to: "USD", bank: bank))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 6) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }
}
