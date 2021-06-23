//
//  Sum.swift
//  TDDSwift
//
//  Created by gurrium on 2021/05/04.
//

import Foundation

class Sum: Expression {
    let augend: Expression
    let addend: Expression

    init(_ augend: Expression, _ addend: Expression) {
        self.augend = augend
        self.addend = addend
    }

    func reduce(to currency: String, bank: Bank) -> Money {
        let amount = bank.reduce(augend, to: currency).amount + bank.reduce(addend, to: currency).amount
        return Money(amount: amount, currency: currency)
    }

    func plus(_ addend: Expression) -> Expression {
        Sum(self, addend)
    }

    func times(_ multiplier: Int) -> Expression {
        Sum(augend.times(multiplier), addend.times(multiplier))
    }
}
