//
//  PayViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 26.09.22.
//

import UIKit

/// Экран оплаты заказа
class PayViewController: UIViewController {
    private lazy var costGoodLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Стоимость вашего заказа - \(cost)"
        label.frame = CGRect(x: 0, y: 100, width: 400, height: 50)
        label.textAlignment = .center
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var paymentButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0,
                              y: costGoodLabel.frame.maxY + 100,
                              width: costGoodLabel.frame.width,
                              height: 50)
        button.center.x = view.center.x
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buyAlertAction), for: .touchDown)
        return button
    }()
    
    var cost = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(UIImageView(image: UIImage(named: "BackgroundImage")))
        view.addSubview(costGoodLabel)
        view.addSubview(paymentButton)
    }
    
    @objc private func buyAlertAction() {
            let alertController = UIAlertController(title: "Оплатить \(cost)p?", message: "",
                                                    preferredStyle: .alert)
            let alertControllerOkAction = UIAlertAction(title: "Оk", style: .default) { _ in
                self.costGoodLabel.text = "Спасибо за покупку!"
            }
            let alertControllerCancelAction = UIAlertAction(title: "Отменить оплату", style: .cancel)
            alertController.addAction(alertControllerOkAction)
            alertController.addAction(alertControllerCancelAction)
            present(alertController, animated: true)
        }
}
