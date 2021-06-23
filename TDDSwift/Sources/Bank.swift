//
//  Bank.swift
//  TDDSwift
//
//  Created by gurrium on 2021/05/04.
//

import Foundation

class Bank {
    struct Key: Hashable {
        let from: String
        let to: String

        internal init(_ from: String, _ to: String) {
            self.from = from
            self.to = to
        }
    }

    var rates: Dictionary<Key, Int> = [:]

    func reduce(_ source: Expression, to currency: String) -> Money {
        source.reduce(to: currency, bank: self)
    }

    func addRate(_ rate: Int, from: String, to: String) {
        rates[Key(from, to)] = rate
    }

    func rate(from: String, to: String) -> Int {
        from == to ? 1 : rates[Key(from, to)]!
    }
}
