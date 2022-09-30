//
//  ChooseDishViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 30.09.22.
//
import UIKit

/// Экран выбора блюда
final class ChooseDishViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background_2"))
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return imageView
    }()

    private lazy var pizzaButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0,
                              y: 140,
                              width: view.frame.width / 4 * 3,
                              height: 80)
        button.center.x = view.center.x
        button.setTitle("Пицца", for: .normal)
        button.layer.borderWidth = CGFloat(1)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushPizzaButtonAction), for: .touchDown)
        return button
    }()
    
    private lazy var pizzaImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pizzas"))
        imageView.frame = CGRect(x: pizzaButton.frame.minX,
                                 y: pizzaButton.frame.minY,
                                 width: pizzaButton.frame.height,
                                 height: pizzaButton.frame.height)
        return imageView
    }()
    
    private lazy var sushiButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: pizzaButton.frame.minX,
                              y: pizzaButton.frame.maxY + 50,
                              width: pizzaButton.frame.width,
                              height: 80)
        button.setTitle("Суши", for: .normal)
        button.layer.borderWidth = CGFloat(1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var sushiImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sushi"))
        imageView.frame = CGRect(x: sushiButton.frame.minX,
                                 y: sushiButton.frame.minY,
                                 width: sushiButton.frame.height,
                                 height: sushiButton.frame.height)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc private func pushPizzaButtonAction() {
        let choosePizzaVC = ChoosePizzaViewController()
        let barButtonItem = UIBarButtonItem()
        barButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = barButtonItem
        navigationController?.pushViewController(choosePizzaVC, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureSubViews()
        configureNavController()
    }
    
    private func configureSubViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(pizzaImageView)
        view.addSubview(pizzaButton)
        view.addSubview(sushiImageView)
        view.addSubview(sushiButton)
    }
    
    private func configureNavController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        title = "Food"
    }
    
}
