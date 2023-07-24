//
//  MainView.swift
//  BankManagerUIApp
//
//  Created by 비모 on 2023/07/19.
//

import UIKit

protocol MainStackViewDelegate: AnyObject {
    func addWaitingCustomer()
    func initialization()
}

class MainStackView: UIStackView {
    weak var mainStackViewDelegate: MainStackViewDelegate?
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    } ()

    private let addCustomerButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.addTarget(self, action: #selector(didTappedAddCustomerButton), for: .touchUpInside)

        return button
    } ()

    private let initializationButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.addTarget(self, action: #selector(didTappedInitializationButton), for: .touchUpInside)

        return button
    } ()

    private let workingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업무시간 - 00:00:000"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center

        return label
    } ()

    private let workStatusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    } ()

    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.backgroundColor = .systemGreen

        return label
    } ()

    private let workingLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo

        return label
    } ()

    private let customerListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    } ()

    private let waitingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    } ()

    private let waitingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    } ()

    private let workingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    } ()

    private let workingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    } ()
    
    convenience init() {
        self.init(frame: CGRectZero)

        configureUI()
        setupConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [buttonStackView, workingTimeLabel, workStatusStackView, customerListStackView].forEach {
            addSubview($0)
        }
        
        [addCustomerButton, initializationButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [waitingLabel, workingLabel].forEach {
            workStatusStackView.addArrangedSubview($0)
        }
        
        [waitingScrollView, workingScrollView].forEach {
            customerListStackView.addArrangedSubview($0)
        }
        
        waitingScrollView.addSubview(waitingStackView)
        workingScrollView.addSubview(workingStackView)
    }
    
    private func setupConstraints() {
        setupButtonStackViewConstraints()
        setupWorkingTimeLabelConstraints()
        setupWorkStatusStackViewConstraints()
        setupCustomerListStackViewConstraints()
        setupWaitingScrollViewConstraints()
        setupWaitingStackViewConstraints()
        setupWorkingScrollViewConstraints()
        setupWorkingStackViewConstraints()
    }
    
    func addToWaitingStackView(label: UILabel) {
        waitingStackView.addArrangedSubview(label)
    }
    
    private func addToWorkingStackView(label: UILabel) {
        workingStackView.addArrangedSubview(label)
    }
    
    func assignWork() {
        guard let label = waitingStackView.arrangedSubviews.first as? UILabel else { return }
        addToWorkingStackView(label: label)
    }
    
    func initalization() {
        workingTimeLabel.text = "업무시간 - 00:00:000"
        removeAllFromWaitingStackView()
        removeAllFromWorkingStackView()
    }
    
    private func removeAllFromWaitingStackView() {
        waitingStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func removeAllFromWorkingStackView() {
        workingStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    // MARK: - Delegate
    @objc func didTappedAddCustomerButton() {
        mainStackViewDelegate?.addWaitingCustomer()
    }
    
    @objc func didTappedInitializationButton() {
        mainStackViewDelegate?.initialization()
    }
}

// MARK: - Contraints
extension MainStackView {
    private func setupButtonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    private func setupWorkingTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            workingTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            workingTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            workingTimeLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupWorkStatusStackViewConstraints() {
        NSLayoutConstraint.activate([
            workStatusStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            workStatusStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            workStatusStackView.topAnchor.constraint(equalTo: workingTimeLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupCustomerListStackViewConstraints() {
        NSLayoutConstraint.activate([
            customerListStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customerListStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customerListStackView.topAnchor.constraint(equalTo: workStatusStackView.bottomAnchor),
            customerListStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupWaitingScrollViewConstraints() {
//        NSLayoutConstraint.activate([
//            waitingScrollView.frameLayoutGuide.topAnchor.constraint(equalTo: customerListStackView.topAnchor),
//            waitingScrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: customerListStackView.bottomAnchor)
//        ])
    }
    
    private func setupWaitingStackViewConstraints() {
        NSLayoutConstraint.activate([
            waitingStackView.leadingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.leadingAnchor),
            waitingStackView.trailingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.trailingAnchor),
            waitingStackView.topAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.topAnchor, constant: 16),
            waitingStackView.bottomAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.bottomAnchor),
            waitingStackView.widthAnchor.constraint(equalTo: waitingScrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupWorkingScrollViewConstraints() {
//        NSLayoutConstraint.activate([
//            workingScrollView.frameLayoutGuide.topAnchor.constraint(equalTo: customerListStackView.topAnchor),
//            workingScrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: customerListStackView.bottomAnchor)
//        ])
    }
    
    private func setupWorkingStackViewConstraints() {
        NSLayoutConstraint.activate([
            workingStackView.leadingAnchor.constraint(equalTo: workingScrollView.contentLayoutGuide.leadingAnchor),
            workingStackView.trailingAnchor.constraint(equalTo: workingScrollView.contentLayoutGuide.trailingAnchor),
            workingStackView.topAnchor.constraint(equalTo: workingScrollView.contentLayoutGuide.topAnchor, constant: 16),
            workingStackView.bottomAnchor.constraint(equalTo: workingScrollView.contentLayoutGuide.bottomAnchor),
            workingStackView.widthAnchor.constraint(equalTo: workingScrollView.frameLayoutGuide.widthAnchor, multiplier: 1, constant: -1)
        ])
    }
}
