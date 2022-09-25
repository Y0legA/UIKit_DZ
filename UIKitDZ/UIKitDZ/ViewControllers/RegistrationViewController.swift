//
//  RegistrationViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран регистрации
class RegistrationViewController: UIViewController {
    
    private lazy var applicationNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Birthday Reminder"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.layer.borderWidth = CGFloat(1)
        label.frame = CGRect(x: 0, y: 100, width: 200, height: 100)
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var sighInLabel: UILabel = {
        var label = UILabel()
        label.text = "Sigh In"
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 25)
        label.frame = CGRect(x: 60, y: applicationNameLabel.frame.maxY + 100, width: 100, height: 50)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        var label = UILabel()
        label.text = "Email"
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 60, y: sighInLabel.frame.maxY, width: 50, height: 30)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        var textField = UITextField()
        textField.frame = CGRect(x: 60, y: emailLabel.frame.maxY, width: view.bounds.width - 120, height: 30)
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Password"
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 60, y: emailTextField.frame.maxY + 40, width: 100, height: 30)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.isSecureTextEntry = true
        textField.frame = CGRect(x: 60, y: passwordLabel.frame.maxY, width: view.bounds.width - 120, height: 30)
        return textField
    }()
    
    private lazy var eyeButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "eye_closed"), for: .normal)
        button.frame = CGRect(x: passwordTextField.frame.maxX - 30,
                              y: passwordTextField.frame.minY,
                              width: 30,
                              height: 30)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(eyeButtonToggle), for: .touchDown)
        return button
    }()
    
    private lazy var faceIdLabel: UILabel = {
        var label = UILabel()
        label.text = "вход по Face ID"
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: passwordTextField.frame.maxY + 30, width: 150, height: 30)
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var faceIdSwith: UISwitch = {
        var switcher = UISwitch()
        switcher.isOn = true
        switcher.frame = CGRect(x: faceIdLabel.frame.maxX + 10,
                                y: faceIdLabel.frame.minY,
                                width: 30,
                                height: 60)
        switcher.tintColor = .gray
        return switcher
    }()
    
    private lazy var transitionButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0,
                              y: faceIdSwith.frame.maxY + 50,
                              width: passwordTextField.frame.width,
                              height: sighInLabel.frame.height)
        button.center.x = view.center.x
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(transitionForNextViewController), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Метод для инвертирования глаза в поле ввода пароля
    @objc private func eyeButtonToggle() {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            eyeButton.setImage(UIImage(named: "eye_open"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            eyeButton.setImage(UIImage(named: "eye_closed"), for: .normal)
        }
    }
    
    @objc private func transitionForNextViewController() {
        let birthdayViewController = BirthdayViewController()
        navigationController?.pushViewController(birthdayViewController, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(applicationNameLabel)
        view.addSubview(sighInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        configureTextField(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(eyeButton)
        configureTextField(passwordTextField)
        view.addSubview(faceIdLabel)
        view.addSubview(faceIdSwith)
        view.addSubview(transitionButton)
    }
    
    /// Метод для отрисовки нижнего подчеркивания
    private func configureTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: textfield.bounds.height,
                                  width: textfield.bounds.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
}
