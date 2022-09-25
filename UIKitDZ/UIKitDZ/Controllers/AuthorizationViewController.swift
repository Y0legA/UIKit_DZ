//
//  AuthorizationViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран ввода логина и пароля
class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    @IBAction func enterButtonAction(_ sender: UIButton) {
        
        func secureAlert() {
            let alertController = UIAlertController(title: "Ошибка",
                                                    message: "Введенные данные неверны",
                                                    preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .cancel)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        let secureData = Sequre()
        guard (self.emailTextField.text == secureData.login)
                && (self.passwordTextField.text == secureData.password) else { return secureAlert() }
        if let target = storyboard?.instantiateViewController(withIdentifier: "secondViewController")
            as? AuthorizationViewController {
            navigationController?.pushViewController(target, animated: true)
        }
    }

    @IBAction func eyeAction(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    private func configureUI() {
        self.configureTextField(self.emailTextField)
        self.configureTextField(self.passwordTextField)
    }
    
    private func configureTextField(_ textfield: UITextField) {
           let bottomLine = CALayer()
           bottomLine.frame = CGRect(x: 0.0,
                                     y: textfield.bounds.height,
                                     width: textfield.bounds.width, height: 1.0)
        bottomLine.backgroundColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
           textfield.borderStyle = UITextField.BorderStyle.none
           textfield.layer.addSublayer(bottomLine)
       }
}
