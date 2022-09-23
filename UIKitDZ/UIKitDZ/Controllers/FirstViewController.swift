//
//  ViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Cтартовый контроллер
class FirstViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTextField(self.emailTextfield)
        self.configureTextField(self.passwordTextfield)
    }
    
    private func configureTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: textfield.bounds.height,
                                  width: textfield.bounds.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        
        func secureAlert() {
            let alertController = UIAlertController(title: "Ошибка",
                                                    message: "Введенные данные неверны",
                                                    preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .cancel)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        let secureData = SecureData()
        guard (self.emailTextfield.text == secureData.login)
                && (self.passwordTextfield.text == secureData.password) else { return secureAlert() }
        if let target = storyboard?.instantiateViewController(withIdentifier: "secondViewController")
            as? FirstViewController {
            navigationController?.pushViewController(target, animated: true)
        }
    }
    
    @IBAction func eyeAction(_ sender: Any) {
        if passwordTextfield.isSecureTextEntry {
            passwordTextfield.isSecureTextEntry = false
        } else {
            passwordTextfield.isSecureTextEntry = true
        }
    }
}
