//
//  AutorizationViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран авторизации
final class AutorizationViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background_1"))
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return imageView
    }()
    
    private lazy var pizzariyaLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.frame = CGRect(x: 0, y: 100, width: 160, height: 150)
        imageView.center.x = view.center.x
        return imageView
    }()
    
    private lazy var namePizzariyaLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: pizzariyaLogoImageView.frame.midY - 10, width: 100, height: 60))
        label.center.x = pizzariyaLogoImageView.center.x
        label.text = "Twister Pizza"
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next", size: 18)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        var label = UILabel()
        label.text = "Email"
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.frame = CGRect(x: 60, y: pizzariyaLogoImageView.frame.maxY + 50, width: 50, height: 30)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        var textField = UITextField()
        textField.frame = CGRect(x: 60, y: emailLabel.frame.maxY, width: view.bounds.width - 120, height: 30)
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Password"
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 16)
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
                              y: passwordTextField.frame.maxY + 130,
                              width: passwordTextField.frame.width,
                              height: 50)
        button.center.x = view.center.x
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6582818627, green: 0.7757439017, blue: 0.9822301269, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchDown)
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
    
    @objc private func enterButtonAction() {
        let secureData = Secure()
        guard (self.emailTextField.text == secureData.login)
                && (self.passwordTextField.text == secureData.password) else {
            secureAlert()
            return
        }
        let chooseDishVC = ChooseDishViewController()
        let navigationVewController = UINavigationController(rootViewController: chooseDishVC)
        navigationVewController.modalPresentationStyle = .fullScreen
        present(navigationVewController, animated: true)
        
    }
    
    private func secureAlert() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Введенные данные неверны",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func configureUI() {
        passwordTextField.delegate = self
        configureSubwayViews()
        configureTextField(emailTextField)
        configureTextField(passwordTextField)
    }
    
    private func configureSubwayViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        view.addSubview(pizzariyaLogoImageView)
        view.addSubview(namePizzariyaLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(eyeButton)
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

/// UITextFieldDelegate
extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
