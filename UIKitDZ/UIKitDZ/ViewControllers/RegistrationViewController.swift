//
//  RegistrationViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 3.10.22.
//

import UIKit
/// Экран регистрации
final class RegistrationViewController: UIViewController {
    // MARK: - Private IBOutlet
    @IBOutlet private weak var nameUserTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var birthdayDayTextField: UITextField!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Public properties
    var custumerInfo = CustumerInfo()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Private IBActions
    @IBAction private func addNewCustumerAction(_ sender: Any) {
        custumerInfo.nameUser = nameUserTextField.text ?? ""
        custumerInfo.phoneNumber = phoneNumberTextField.text ?? ""
        custumerInfo.birthday = birthdayDayTextField.text ?? ""
        custumerInfo.login = loginTextField.text ?? ""
        custumerInfo.password = passwordTextField.text ?? ""
        CommonCustumerDefaults.addCustumer(custumerInfo)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureTextFields()
    }
    
    private func configureTextFields() {
        nameUserTextField.delegate = self
        phoneNumberTextField.delegate = self
        birthdayDayTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(forName: UITextField.keyboardDidShowNotification,
                                               object: nil, queue: nil) { [weak self] _ in
            self?.view.frame.origin.y = -100
        }
        
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification,
                                               object: nil, queue: nil) {  [weak self] _ in
            guard let self = self else { return }
            self.view.frame.origin.y = 0
        }
    }
}
    // MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }
}
