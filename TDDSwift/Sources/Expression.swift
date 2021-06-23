//
//  Expression.swift
//  TDDSwift
//
//  Created by gurrium on 2021/05/04.
//

import Foundation

protocol Expression {
    func reduce(to currency: String, bank: Bank) -> Money
    func plus(_ addend: Expression) -> Expression
    func times(_ multiplier: Int) -> Expression
}
