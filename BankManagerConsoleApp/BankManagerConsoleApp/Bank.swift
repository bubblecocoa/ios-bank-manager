//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 비모 on 2023/07/12.
//

struct Bank {
    let banker: Banker
    var customerWatingQueue: CustomerWaitingQueue<Customer>
    
    mutating func startWork() {
        let totalCustomerCount = customerWatingQueue.count
        
        while !customerWatingQueue.isEmpty {
            guard let customer = customerWatingQueue.dequeue() else { continue }
            banker.doWork(customerNumber: customer.number)
        }
        
        printWorkResult(totalCustomerCount: totalCustomerCount)
    }
    
    func printWorkResult(totalCustomerCount: Int) {
        let workTime = 0.7 * Double(totalCustomerCount)
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalCustomerCount)명이며, 총 업무시간은 \(workTime)초입니다.")
    }
}
