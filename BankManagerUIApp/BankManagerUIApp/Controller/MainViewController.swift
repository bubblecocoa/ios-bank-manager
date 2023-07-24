//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func addWorkingCustomer()
}

class MainViewController: UIViewController {
    weak var mainViewControllerDelegate: MainViewControllerDelegate?
    
    private let bank = Bank()
    private var customerCount: Int = 1
    
    private lazy var mainStackView: MainStackView = {
        let stackView = MainStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.mainStackViewDelegate = self
        
        return stackView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewBackground()
        configureMainView()
        setUpMainViewConstraints()
    }
    
    private func setViewBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureMainView() {
        view.addSubview(mainStackView)
    }
    
    private func setUpMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Delegate
extension MainViewController: MainStackViewDelegate {
    func addWaitingCustomer() {
        for _ in 1...10 {
            guard let serviceNeeded = ServiceType.allCases.randomElement() else { return }
            
            let customer = Customer(number: customerCount, serviceNeeded: serviceNeeded)
            
            let customorLabel: UILabel = {
                let label = UILabel()
                label.text = "\(customer.number) - \(customer.serviceNeeded.description)"
                label.textColor = customer.serviceNeeded == .deposit ? .black : .systemPurple
                label.font = UIFont.preferredFont(forTextStyle: .body)
                label.textAlignment = .center
                
                return label
            } ()
            
            mainStackView.addToWaitingStackView(label: customorLabel)
            
            bank.enqueue(customer: customer)
            
            customerCount += 1
        }
    }
    
    func initialization() {
//        customerCount = 1
//        mainStackView.initalization()
        mainStackView.assignWork()
    }
}
