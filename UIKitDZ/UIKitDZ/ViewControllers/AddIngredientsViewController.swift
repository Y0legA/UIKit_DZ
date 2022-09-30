//
//  AddIngredientsViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 28.09.22.
//

import UIKit

/// протокол для делегирования вызова метода удаления экранов и перехода к экрану меню
protocol PopToRootVC: AnyObject {
    func goToBack()
}
/// Экран добавления ингридиентов к пицце
final class AddIngredientsViewController: UIViewController {
    private lazy var namePizzaLabel: UILabel = {
        var label = UILabel()
        label.text = pizzaProperty?.name
        label.font = UIFont(name: "Avenir Next", size: 35)
        label.frame = CGRect(x: 50, y: 30, width: view.frame.width - 100, height: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pizzaImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: pizzaProperty?.image ?? ""))
        imageView.frame = CGRect(x: 0, y: namePizzaLabel.frame.maxY + 30, width: 300, height: 300)
        imageView.center.x = view.center.x
        return imageView
    }()
    
    private lazy var cheeseMocarelaLabel: UILabel = {
          var label = UILabel()
          label.text = "Сыр моцарела"
          label.font = UIFont(name: "Avenir Next Demi Bold", size: 17)
        label.frame = CGRect(x: namePizzaLabel.frame.minX, y: view.frame.midY, width: 150, height: 30)
          return label
      }()
      
      private lazy var cheeseMocarelaSwith: UISwitch = {
          var switcher = UISwitch()
          switcher.isOn = true
          switcher.frame = CGRect(x: view.frame.maxX - 100, y: view.frame.midY, width: 30, height: 60)
          return switcher
      }()
    
    private lazy var hamLabel: UILabel = {
          var label = UILabel()
          label.text = "Ветчина"
          label.font = UIFont(name: "Avenir Next Demi Bold", size: 17)
          label.frame = CGRect(x: namePizzaLabel.frame.minX, y: view.frame.midY + 60, width: 150, height: 30)
          return label
      }()
      
      private lazy var hamSwith: UISwitch = {
          var switcher = UISwitch()
          switcher.isOn = true
          switcher.frame = CGRect(x: view.frame.maxX - 100, y: view.frame.midY + 60, width: 30, height: 20)
          return switcher
      }()
    
    private lazy var mushroomsLabel: UILabel = {
          var label = UILabel()
          label.text = "Грибы"
          label.font = UIFont(name: "Avenir Next Demi Bold", size: 17)
          label.frame = CGRect(x: namePizzaLabel.frame.minX, y: hamLabel.frame.maxY + 30, width: 150, height: 30)
          return label
      }()
      
      private lazy var mushroomsSwith: UISwitch = {
          var switcher = UISwitch()
          switcher.isOn = true
          switcher.frame = CGRect(x: view.frame.maxX - 100, y: hamLabel.frame.minY + 60, width: 30, height: 20)
          return switcher
      }()
    
    private lazy var maslinsLabel: UILabel = {
          var label = UILabel()
          label.text = "Маслины"
          label.font = UIFont(name: "Avenir Next Demi Bold", size: 17)
          label.frame = CGRect(x: namePizzaLabel.frame.minX, y: mushroomsLabel.frame.maxY + 30, width: 150, height: 30)
          return label
      }()
      
      private lazy var maslinsSwith: UISwitch = {
          var switcher = UISwitch()
          switcher.isOn = true
          switcher.frame = CGRect(x: view.frame.maxX - 100, y: mushroomsLabel.frame.minY + 60, width: 30, height: 20)
          return switcher
      }()
    
    private lazy var caloriesButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: view.frame.maxY - 200, width: namePizzaLabel.frame.width, height: 50)
        button.center.x = view.center.x
        button.setTitle("Калории", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5589334965, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(caloriesButtonAction), for: .touchDown)
        return button
    }()
    
    private lazy var chooseButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: view.frame.maxY - 130, width: namePizzaLabel.frame.width, height: 50)
        button.center.x = view.center.x
        button.setTitle("Выбрать", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5589334965, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(choosePizzaButtonAction), for: .touchDown)
        return button
    }()
    
    weak var delegate: PopToRootVC?
    var pizzaProperty: PropertyOfPizza?
    var index = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Переход на экран калорий
    @objc private func caloriesButtonAction() {
        let caloriesVC = CaloriesViewController()
        caloriesVC.namePizza = pizzaProperty?.name
        caloriesVC.descriptionPizza = pizzaProperty?.description
        caloriesVC.caloriesPizza = pizzaProperty?.calorii
        present(caloriesVC, animated: true)
    }
    
    /// Переход на экран оплаты
    @objc private func choosePizzaButtonAction() {
        let chooseIngredientsVC = PayViewController()
        chooseIngredientsVC.delegate = self
        chooseIngredientsVC.pizza = ("Пицца \(namePizzaLabel.text ?? "")", true)
        chooseIngredientsVC.cheeseMocarela = (cheeseMocarelaLabel.text ?? "", cheeseMocarelaSwith.isOn)
        chooseIngredientsVC.ham = (hamLabel.text ?? "", hamSwith.isOn)
        chooseIngredientsVC.mushrooms = (mushroomsLabel.text ?? "", mushroomsSwith.isOn)
        chooseIngredientsVC.maslins = (maslinsLabel.text ?? "", maslinsSwith.isOn)
        let navigationViewController = UINavigationController(rootViewController: chooseIngredientsVC)
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSubviews()
    }
    
    private func configureSubviews() {
        view.addSubview(namePizzaLabel)
        view.addSubview(pizzaImageView)
        view.addSubview(cheeseMocarelaLabel)
        view.addSubview(cheeseMocarelaSwith)
        view.addSubview(hamLabel)
        view.addSubview(hamSwith)
        view.addSubview(mushroomsLabel)
        view.addSubview(mushroomsSwith)
        view.addSubview(maslinsLabel)
        view.addSubview(maslinsSwith)
        view.addSubview(caloriesButton)
        view.addSubview(chooseButton)
    }
}

/// PopToRootVC
extension AddIngredientsViewController: PopToRootVC {
    func goToBack() {
        if let viewController = self.presentingViewController as? UINavigationController {
            view.isHidden = true
            self.dismiss(animated: false)
            viewController.popToRootViewController(animated: false)
        }
    }
}
