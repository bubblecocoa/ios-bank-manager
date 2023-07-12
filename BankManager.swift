//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

struct BankManager {
    func selectMenu() {
        while true {
            printMenuOption()
            
            guard let input = readLine() else { return }
            
            switch input {
            case "1":
                startBankWork()
            case "2":
                return
            default:
                print("입력이 잘못되었습니다.")
            }
        }
    }

    func printMenuOption() {
        print("1 : 은행개점")
        print("2 : 종료")
        print("입력 : ", terminator: "")
    }

    func startBankWork() {
        var customerWaitingQueue: CustomerWaitingQueue<Customer> = CustomerWaitingQueue()
        
        for number in 1...Int.random(in: 10...30) {
            customerWaitingQueue.enqueue(Customer(number: number))
        }
        
        var bank = Bank(banker: Banker(), customerWatingQueue: customerWaitingQueue)
        bank.startWork()
    }
}
