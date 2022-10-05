//
//  EnterViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 3.10.22.
//

import UIKit
/// Экран авторизации
final class EnterViewController: UIViewController {
    // MARK: - Private IBOutlet
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.text = ""
        passwordTextField.text = ""
    }
   
    // MARK: - Private IBAction
    @IBAction private func enterButtonAction(_ sender: Any) {
        let custumers = CommonCustumerDefaults.custumers
        guard let custumer = custumers.first(where: { $0.login == loginTextField.text })
        else {
            callAlert(title: "Ошибка", message: "Пользователь не найден, пройдите процедуру регистрации")
            loginTextField.text = ""
            passwordTextField.text = ""
            return
        }
        guard custumer.login == loginTextField.text && custumer.password == passwordTextField.text else {
            callAlert(title: "Ошибка", message: "Логин или пароль неверны")
            return
        }
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "appViewController") as?
                AppViewController else { return }
        targetVC.nameCustumer = custumer.nameUser
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    @IBAction private func registerButtonAction(_ sender: Any) {
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "registrationViewController")
                as? RegistrationViewController else { return }
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    @IBAction private func eyeAction(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    // MARK: - Private Methods
    private func callAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let anyAlertControllerAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(anyAlertControllerAction)
        present(alertController, animated: true)
    }
    
}
