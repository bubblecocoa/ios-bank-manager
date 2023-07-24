//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by yyss99, 비모 on 2023/07/13.
//

import Foundation

class Bank {
    private let depositBankClerk = BankClerk(serviceType: .deposit, numberOfBankClerk: 2)
    private let loanBankClerk = BankClerk(serviceType: .loan, numberOfBankClerk: 1)
    private var customerWaitingQueue: CustomerWaitingQueue<Customer> = CustomerWaitingQueue()
    
    func work() {
        let group = DispatchGroup()
        
        while let customer = customerWaitingQueue.dequeue() {
            // 뷰의 작업중 목록으로 인원 옮기기
            switch customer.serviceNeeded {
            case .deposit:
                depositBankClerk.work(for: customer, in: group)
            case .loan:
                loanBankClerk.work(for: customer, in: group)
            }
        }
        
        group.wait()
    }
    
    func enqueue(customer: Customer) {
        customerWaitingQueue.enqueue(customer)
    }
}
