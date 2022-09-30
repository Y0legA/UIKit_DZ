//
//  PayViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 28.09.22.
//

import UIKit

/// Экран оплаты
final class PayViewController: UIViewController {
    private lazy var yourOrderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 200, height: 30))
        label.text = "Ваш заказ:"
        label.font = UIFont(name: "Avenir Next", size: 25)
        return label
    }()
    
    private lazy var payCardLabel: UILabel = {
        var label = UILabel()
        label.text = "Оплата картой"
        label.font = UIFont(name: "Avenir Next", size: 25)
        label.frame = CGRect(x: 50, y: view.frame.maxY - 250, width: 200, height: 30)
        return label
    }()
    
    private lazy var payCardSwith: UISwitch = {
        var switcher = UISwitch()
        switcher.isOn = true
        switcher.frame = CGRect(x: view.frame.maxX - 100, y: view.frame.maxY - 250, width: 50, height: 30)
        switcher.addTarget(self, action: #selector(payCardSwitchAction), for: .valueChanged)
        return switcher
    }()
    
    private lazy var payCashLabel: UILabel = {
        var label = UILabel()
        label.text = "Наличными"
        label.font = UIFont(name: "Avenir Next", size: 25)
        label.frame = CGRect(x: 50, y: view.frame.maxY - 200, width: 200, height: 30)
        return label
    }()
    
    private lazy var payCashSwith: UISwitch = {
        var switcher = UISwitch()
        switcher.isOn = false
        switcher.frame = CGRect(x: view.frame.maxX - 100, y: view.frame.maxY - 200, width: 50, height: 30)
        switcher.addTarget(self, action: #selector(payCashSwitchAction), for: .valueChanged)
        return switcher
    }()
    
    private lazy var payButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: view.frame.maxY - 150, width: view.frame.width - 70, height: 50)
        button.center.x = view.center.x
        button.setTitle("Выбрать", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setImage(UIImage(named: "applePay"), for: .normal)
        button.addTarget(self, action: #selector(payButtonAction), for: .touchDown)
        return button
    }()
    
    weak var delegate: PopToRootVC?
    var pizza = ("", true)
    var cheeseMocarela = ("", true)
    var ham = ("", true)
    var mushrooms = ("", true)
    var maslins = ("", true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    @objc private func payCardSwitchAction(_ sender: UISwitch) {
        payCashSwith.isOn.toggle()
    }
    
    @objc private func payCashSwitchAction(_ sender: UISwitch) {
        payCardSwith.isOn.toggle()
    }
    
    @objc private func payButtonAction() {
        let alertController = UIAlertController(title: "Заказ оплачен!",
                                                message: "Ваш заказ доставят в течении 15 минут! \nПриятного аппетита",
                                                preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.view.isHidden = true
            self.dismiss(animated: true)
            self.delegate?.goToBack()
        }
        alertController.addAction(alertControllerAction)
        self.present(alertController, animated: true)
    }
    
    /// Метод создания блока добавления ингредиентов
    private func createDescriptionLabels(_ coordinates: CGRect) {
        let propertysPizza = [pizza, cheeseMocarela, ham, mushrooms, maslins]
        var yCoordinate = coordinates.minY + 40
        for (index, value) in propertysPizza.enumerated() {
            if !value.1 { continue }
            let label = UILabel()
            label.text = "\(index + 1) \(value.0)"
            label.font = UIFont(name: "Avenir Next", size: 25)
            label.frame = CGRect(x: 20, y: yCoordinate, width: view.frame.width, height: 40)
            yCoordinate += 40
            view.addSubview(label)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSubviews()
        createDescriptionLabels(yourOrderLabel.frame)
    }
    
    private func configureSubviews() {
        view.addSubview(yourOrderLabel)
        view.addSubview(payCardLabel)
        view.addSubview(payCardSwith)
        view.addSubview(payCashLabel)
        view.addSubview(payCashSwith)
        view.addSubview(payButton)
    }
}
