//
//  SecondTrafficLightViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 14.10.22.
//

import UIKit

// Creating constraints using NSLayoutConstraint
final class SecondTrafficLightViewController: UIViewController {
    private enum Constants {
        static let title = "NSLayoutConstraint"
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
            NSLayoutConstraint(item: titleLabel, attribute: .top,
                               relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top,
                               multiplier: 1.0, constant: 5),
            NSLayoutConstraint(item: titleLabel, attribute: .width,
                               relatedBy: .equal, toItem: nil, attribute: .width,
                               multiplier: 1.0, constant: 200),
            NSLayoutConstraint(item: titleLabel, attribute: .height,
                               relatedBy: .equal, toItem: nil, attribute: .height,
                               multiplier: 1.0, constant: 15),
            NSLayoutConstraint(item: titleLabel, attribute: .centerX,
                               relatedBy: .equal, toItem: view, attribute: .centerX,
                               multiplier: 1.0, constant: 0)
        ])
    }
    
    private func configureBlackView() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: blackView, attribute: .top,
                               relatedBy: .equal, toItem: redView, attribute: .top,
                               multiplier: 1.0, constant: -5),
            NSLayoutConstraint(item: blackView, attribute: .leading,
                               relatedBy: .equal, toItem: redView, attribute: .leading,
                               multiplier: 1.0, constant: -5),
            NSLayoutConstraint(item: blackView, attribute: .trailing,
                               relatedBy: .equal, toItem: redView, attribute: .trailing,
                               multiplier: 1.0, constant: 5),
            NSLayoutConstraint(item: blackView, attribute: .bottom,
                               relatedBy: .equal, toItem: greenView, attribute: .bottom,
                               multiplier: 1.0, constant: 5)
        ])
    }
    
    private func configureRedView() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: redView, attribute: .bottom,
                               relatedBy: .equal, toItem: yellowView, attribute: .top,
                               multiplier: 1.0, constant: -5),
            NSLayoutConstraint(item: redView, attribute: .width,
                               relatedBy: .equal, toItem: yellowView, attribute: .width,
                               multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: redView, attribute: .height,
                               relatedBy: .equal, toItem: yellowView, attribute: .height,
                               multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: redView, attribute: .centerX,
                               relatedBy: .equal, toItem: view, attribute: .centerX,
                               multiplier: 1.0, constant: 0)
        ])
    }
    
    private func configureYellowView() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: yellowView, attribute: .centerX,
                               relatedBy: .equal, toItem: view, attribute: .centerX,
                               multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: yellowView, attribute: .centerY,
                               relatedBy: .equal, toItem: view, attribute: .centerY,
                               multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: yellowView, attribute: .width,
                               relatedBy: .equal, toItem: view, attribute: .height,
                               multiplier: 0.33, constant: 0),
            NSLayoutConstraint(item: yellowView, attribute: .height,
                               relatedBy: .equal, toItem: yellowView, attribute: .width,
                               multiplier: 0.8, constant: 0),
        ])
    }
    
    private func configureGreenView() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: greenView, attribute: .top,
                               relatedBy: .equal, toItem: yellowView, attribute: .bottom,
                               multiplier: 1.0, constant: 5),
            NSLayoutConstraint(item: greenView, attribute: .width,
                               relatedBy: .equal, toItem: yellowView, attribute: .width,
                               multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: greenView, attribute: .height,
                               relatedBy: .equal, toItem: yellowView, attribute: .height,
                               multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: greenView, attribute: .centerX,
                               relatedBy: .equal, toItem: view, attribute: .centerX,
                               multiplier: 1.0, constant: 0),
        ])
    }
}
