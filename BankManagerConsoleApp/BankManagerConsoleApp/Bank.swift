//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by yyss99, 비모 on 2023/07/13.
//

import Foundation

final class Bank {
    private var customerWaitingQueue: CustomerWaitingQueue<Customer>
    private var totalCustomerCount: Int = 0
    
    init(customerWaitingQueue: CustomerWaitingQueue<Customer>) {
        self.customerWaitingQueue = customerWaitingQueue
    }
    
    func work() {
        totalCustomerCount = customerWaitingQueue.count
        let start = CFAbsoluteTimeGetCurrent()
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.workDeposit()
        }
        
        DispatchQueue.global().async(group: group) {
            self.workDeposit()
        }
        
        DispatchQueue.global().async(group: group) {
            self.workLoan()
        }
        
        group.wait()
        let totalWorkTime = CFAbsoluteTimeGetCurrent() - start
        
        endOfWork(totalWorkTime: totalWorkTime)
        
    }
    
    private func workDeposit() {
        while let next = self.customerWaitingQueue.peek {
            if next.work == .deposit {
                guard let customer = self.customerWaitingQueue.dequeue() else { continue }
                print("\(customer.number)번 고객 예금 업무 시작")
                Thread.sleep(forTimeInterval: 0.7)
                print("\(customer.number)번 고객 예금 업무 완료")
            }
        }
    }
    
    private func workLoan() {
        while let next = self.customerWaitingQueue.peek {
            if next.work == .lone {
                guard let customer = self.customerWaitingQueue.dequeue() else { continue }
                print("\(customer.number)번 고객 대출 업무 시작")
                Thread.sleep(forTimeInterval: 1.1)
                print("\(customer.number)번 고객 대출 업무 완료")
            }
        }
    }
    
    private func endOfWork(totalWorkTime: CFAbsoluteTime) {
        printWorkResult(totalWorkTime: totalWorkTime)
    }

    private func printWorkResult(totalWorkTime: CFAbsoluteTime) {
        let totalWorkTime = String(format: "%.2f", totalWorkTime)
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalCustomerCount)명이며, 총 업무시간은 \(totalWorkTime)초 입니다.")
    }
}
