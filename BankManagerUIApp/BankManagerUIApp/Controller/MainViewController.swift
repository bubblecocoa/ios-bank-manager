//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private var customerWaitingQueue: CustomerWaitingQueue<Customer> = CustomerWaitingQueue()
    private var customerCount: Int = 1
    
    private let mainStackView: MainStackView = {
        let stackView = MainStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

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
