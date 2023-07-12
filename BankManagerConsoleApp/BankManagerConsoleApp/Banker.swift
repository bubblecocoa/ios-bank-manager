//
//  Banker.swift
//  BankManagerConsoleApp
//
//  Created by 비모 on 2023/07/12.
//

import Foundation

struct Banker {
    func doWork(customerNumber: Int) {
        print("\(customerNumber)번 고객 업무 시작")
        Thread.sleep(forTimeInterval: 0.7)
        print("\(customerNumber)번 고객 업무 완료")
    }
}
