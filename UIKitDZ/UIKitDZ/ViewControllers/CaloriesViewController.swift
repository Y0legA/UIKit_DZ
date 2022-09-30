//
//  CaloriesViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 29.09.22.
//

import UIKit

/// Экран содержания количества калорий в продукте
final class CaloriesViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background_3"))
        imageView.frame = CGRect(x: 0, y: view.frame.midY, width: view.frame.width, height: view.frame.height / 2)
        imageView.center.x = view.center.x
        return imageView
    }()
    
    private lazy var namePizzaLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20,
                                          y: 40,
                                          width: view.frame.width - 40,
                                          height: 50))
        label.text = "Пицца \(namePizza ?? "")"
        label.font = UIFont(name: "Avenir Next", size: 30)
        return label
    }()
    
    private lazy var descriptionPizzaLabel: UILabel = {
        var label = UILabel()
        label.text = "Состав: \(descriptionPizza ?? "")"
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.numberOfLines = 0
        label.frame = CGRect(x: 20,
                             y: namePizzaLabel.frame.maxY + 20,
                             width: view.frame.width - 40,
                             height: 120)
        return label
    }()
    
    private lazy var caloriesPizzaLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20,
                                          y: descriptionPizzaLabel.frame.maxY,
                                          width: view.frame.width - 40,
                                          height: 80))
        label.text = caloriesPizza
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next", size: 20)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        var button = UIButton()
        button.setTitle("К выбору ингридиентов", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.frame = CGRect(x: 0, y: caloriesPizzaLabel.frame.maxY + 30, width: 300, height: 40)
        button.center.x = view.center.x
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        return button
    }()
        
    var namePizza: String?
    var descriptionPizza: String?
    var caloriesPizza: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc private func goBackAction() {
        dismiss(animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        view.addSubview(namePizzaLabel)
        view.addSubview(descriptionPizzaLabel)
        view.addSubview(caloriesPizzaLabel)
        view.addSubview(backButton)
    }
}
