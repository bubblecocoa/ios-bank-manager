//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by yyss99, 비모 on 2023/07/13.
//

struct Customer {
    let number: Int
    let work: Work
}

enum Work: CaseIterable {
    case deposit
    case lone
}
