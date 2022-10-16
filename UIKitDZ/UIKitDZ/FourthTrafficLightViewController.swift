//
//  FourthTrafficLightViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 14.10.22.
//

import UIKit

// Creating constraints using Stack View
final class FourthTrafficLightViewController: UIViewController {
    private enum Constants {
        static let title = "Stack View"
        static let fontArial = "Arial"
        static let fontSize: CGFloat = 24.0
        static let spacing: CGFloat = 16.0
    }
    // MARK: - Private Visual Components
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.text = Constants.title
        label.textAlignment = .center
        label.font = UIFont(name: Constants.fontArial, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [redView, yellowView, greenView])
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let blackView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let redView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let yellowView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let greenView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureView()
        configureTitleLabel()
        configureStackView()
        configureBlackView()
    }
    
    private func configureView() {
        view.addSubview(titleLabel)
        view.addSubview(blackView)
        view.addSubview(stackView)
    }
    
    private func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureBlackView() {
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -5),
            blackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -5),
            blackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5),
            blackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5)
        ])
    }
    
    private func configureStackView() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4)
        ])
    }
}
