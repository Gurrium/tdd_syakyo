//
//  Money.swift
//  TDDSwift
//
//  Created by gurrium on 2021/05/04.
//

import Foundation

class Money: Equatable, Expression {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    func times(_ multiplier: Int) -> Expression {
        Money(amount: amount * multiplier, currency: currency)
    }

    func plus(_ addend: Expression) -> Expression {
        Sum(self, addend)
    }

    func reduce(to currency: String, bank: Bank) -> Money {
        let rate = bank.rate(from: self.currency, to: currency)
        return Money.dollar(amount: self.amount / rate)
    }

    static func dollar(amount: Int) -> Money {
        Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        Money(amount: amount, currency: "CHF")
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }
}
