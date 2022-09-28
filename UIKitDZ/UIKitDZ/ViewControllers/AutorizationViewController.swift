//
//  AutorizationViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 26.09.22.
//

import UIKit

/// Экран авторизации
class AutorizationViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        var imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 70)
        imageView.center.x = view.center.x
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private lazy var applicationImage: UIImageView = {
        var imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: logoImage.frame.maxY, width: view.frame.width, height: view.frame.width)
        imageView.center.x = view.center.x
        imageView.image = UIImage(named: "backgroundImageAutorise")
        return imageView
    }()
    
    private lazy var loginLabel: UILabel = {
        var label = UILabel()
        label.text = "login"
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = #colorLiteral(red: 0.8482570648, green: 0.5876761079, blue: 0.4064556658, alpha: 1)
        label.frame = CGRect(x: 0, y: applicationImage.frame.maxY + 20, width: 50, height: 30)
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        var textField = UITextField()
        textField.textColor = #colorLiteral(red: 0.8482570648, green: 0.5876761079, blue: 0.4064556658, alpha: 1)
        textField.font = UIFont(name: "Avenir Next", size: 25)
        textField.frame = CGRect(x: 60, y: loginLabel.frame.maxY, width: view.bounds.width - 120, height: 30)
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = #colorLiteral(red: 0.8482570648, green: 0.5876761079, blue: 0.4064556658, alpha: 1)
        label.frame = CGRect(x: 0, y: loginTextField.frame.maxY + 40, width: 100, height: 30)
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.textColor = #colorLiteral(red: 0.8482570648, green: 0.5876761079, blue: 0.4064556658, alpha: 1)
        textField.font = UIFont(name: "Avenir Next", size: 25)
        textField.isSecureTextEntry = true
        textField.frame = CGRect(x: 60, y: passwordLabel.frame.maxY, width: view.bounds.width - 120, height: 30)
        return textField
    }()
    
    private lazy var eyeButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.frame = CGRect(x: passwordTextField.frame.maxX - 30,
                              y: passwordTextField.frame.minY,
                              width: 30,
                              height: 30)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(eyeButtonToggleAction), for: .touchDown)
        return button
    }()
    
    private lazy var transitionButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0,
                              y: passwordTextField.frame.maxY + 50,
                              width: passwordTextField.frame.width,
                              height: 50)
        button.center.x = view.center.x
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(transitionForNextViewControllerAction), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Метод для инвертирования глаза в поле ввода пароля
    @objc private func eyeButtonToggleAction() {
        guard passwordTextField.isSecureTextEntry else { return passwordTextField.isSecureTextEntry = true }
            passwordTextField.isSecureTextEntry = false
    }
    
    @objc private func transitionForNextViewControllerAction() {
        let secureData = Secure()
        guard (loginTextField.text == secureData.login)
                && (passwordTextField.text == secureData.password) else { return secureAlert() }
        let goodsVC = ChooseGoodViewController()
        navigationController?.pushViewController(goodsVC, animated: true)
    }
    
    private func secureAlert() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Введенные данные неверны",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel)
        loginTextField.text = ""
        passwordTextField.text = ""
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func configureUI() {
        
        view.backgroundColor = .black
        view.addSubview(logoImage)
        view.addSubview(applicationImage)
        view.addSubview(loginLabel)
        view.addSubview(loginTextField)
        configureTextField(loginTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(eyeButton)
        configureTextField(passwordTextField)
        view.addSubview(transitionButton)
    }
}
