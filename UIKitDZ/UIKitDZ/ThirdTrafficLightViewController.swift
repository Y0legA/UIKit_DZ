//
//  ThirdTrafficLightViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 14.10.22.
//

import UIKit

// Creating constraints using NSLayoutAnchor
final class ThirdTrafficLightViewController: UIViewController {
    private enum Constants {
        static let title = "NSLayoutAnchor"
        static let fontArial = "Arial"
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
        configureYellowView()
        configureRedView()
        configureGreenView()
        configureBlackView()
    }
    
    private func configureView() {
        view.addSubview(titleLabel)
        view.addSubview(blackView)
        view.addSubview(yellowView)
        view.addSubview(redView)
        view.addSubview(greenView)
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
            blackView.topAnchor.constraint(equalTo: redView.topAnchor, constant: -5),
            blackView.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: -5),
            blackView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 5),
            blackView.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 5)
        ])
    }
    
    private func configureRedView() {
        NSLayoutConstraint.activate([
            redView.bottomAnchor.constraint(equalTo: yellowView.topAnchor, constant: -5),
            redView.widthAnchor.constraint(equalTo: yellowView.widthAnchor),
            redView.heightAnchor.constraint(equalTo: yellowView.heightAnchor),
            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureYellowView() {
        NSLayoutConstraint.activate([
            yellowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yellowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            yellowView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33),
            yellowView.heightAnchor.constraint(equalTo: yellowView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureGreenView() {
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 5),
            greenView.widthAnchor.constraint(equalTo: yellowView.widthAnchor),
            greenView.heightAnchor.constraint(equalTo: yellowView.heightAnchor),
            greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
