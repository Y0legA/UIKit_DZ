//
//  AddDetailsViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 23.09.22.
//

import UIKit

/// Экран для ввода анкетных данных
class AddDetailsViewController: UIViewController {
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 20, width: 150, height: 20)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchDown)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: self.view.bounds.maxX - 150, y: 20, width: 150, height: 20)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addDetailsAction), for: .touchDown)
        return button
    }()
    
    private lazy var changeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person")
        imageView.tintColor = .lightGray
        imageView.frame = CGRect(x: 0, y: cancelButton.frame.maxY, width: 150, height: 150)
        imageView.center.x = view.center.x
        return imageView
    }()
    
    private lazy var changeImageButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: changeImageView.frame.maxY, width: 150, height: 20)
        button.center.x = view.center.x
        button.setTitle("Изменить фото", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(changeFotoAction), for: .touchDown)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Имя"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 20, y: changeImageView.frame.maxY + 60, width: 100, height: 15)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.frame = CGRect(x: 20, y: nameLabel.frame.maxY + 5, width: view.bounds.width - 100, height: 30)
        textField.placeholder = "Введите имя"
        return textField
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "Дата"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 20, y: nameTextField.frame.maxY + 20, width: 100, height: 30)
        return label
    }()
    
    private lazy var dataTextField: UITextField = {
        var textField = UITextField()
        textField.frame = CGRect(x: 20, y: dateLabel.frame.maxY, width: view.bounds.width - 100, height: 30)
        textField.inputView = datePicker
        textField.placeholder = "Введите дату"
        return textField
    }()
    
    private lazy var ageLabel: UILabel = {
        var label = UILabel()
        label.text = "Возраст"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 20, y: dataTextField.frame.maxY + 20, width: 100, height: 30)
        return label
    }()
    
    private lazy var ageTextField: UITextField = {
        var textField = UITextField()
        textField.inputView = agePickerView
        textField.frame = CGRect(x: 20, y: ageLabel.frame.maxY, width: view.bounds.width - 100, height: 30)
        textField.placeholder = "Добавить"
        return textField
    }()
    
    private lazy var sexLabel: UILabel = {
        var label = UILabel()
        label.text = "Пол"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 20, y: ageTextField.frame.maxY + 20, width: 100, height: 30)
        return label
    }()
    
    private lazy var sexTextField: UITextField = {
        var textField = UITextField()
        textField.inputView = sexPickerView
        textField.frame = CGRect(x: 20, y: sexLabel.frame.maxY, width: view.bounds.width - 100, height: 30)
        textField.placeholder = "Добавить"
        return textField
    }()
    
    private lazy var instagramLabel: UILabel = {
        var label = UILabel()
        label.text = "Инстаграмм"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.frame = CGRect(x: 20, y: sexTextField.frame.maxY + 20, width: 100, height: 30)
        return label
    }()
    
    private lazy var instagramTextField: UITextField = {
        var textField = UITextField()
        textField.frame = CGRect(x: 20, y: instagramLabel.frame.maxY, width: view.bounds.width - 100, height: 30)
        textField.addTarget(self, action: #selector(instagramAlertAction), for: .allEditingEvents)
        textField.placeholder = "Добавить"
        return textField
    }()
    
    private let datePicker = UIDatePicker()
    private let agePickerView = UIPickerView()
    private let sexPickerView = UIPickerView()
    private let sex = ["Парень", "Девушка"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc private func cancelAction() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    @objc private func addDetailsAction() {
        nameTextField.text = ""
        dataTextField.text = ""
        ageTextField.text = ""
        sexTextField.text = ""
        instagramTextField.text = ""
        let alertController = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    @objc private func changeFotoAction() {
        print("change foto")
    }
    
    @objc private func datePickerButtonAction() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        dataTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func instagramAlertAction() {
        let alertController = UIAlertController(title: "Введите логин", message: "", preferredStyle: .alert)
        let alertControllerOkAction = UIAlertAction(title: "OK", style: .default) { _ in
            let text = alertController.textFields?.first?.text
            guard let text = text else { return }
            self.instagramTextField.text = text
        }
        let alertControllerCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addTextField()
        alertController.textFields?.first?.placeholder = "К примеру -- mario"
        alertController.addAction(alertControllerOkAction)
        alertController.addAction(alertControllerCancelAction)
        present(alertController, animated: true)
    }
    
    private func configureUI() {
        configureSelfView()
        configureTextField(nameTextField)
        createDatePicker()
        configureTextField(dataTextField)
        configureAgePickerView()
        configureSexPickerView()
        configureTextField(ageTextField)
        configureTextField(sexTextField)
        configureTextField(instagramTextField)
    }
    
    private func configureSelfView() {
        view.backgroundColor = .white
        view.addSubview(cancelButton)
        view.addSubview(addButton)
        view.addSubview(changeImageView)
        view.addSubview(changeImageButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateLabel)
        view.addSubview(dataTextField)
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        view.addSubview(sexLabel)
        view.addSubview(sexTextField)
        view.addSubview(instagramLabel)
        view.addSubview(instagramTextField)
    }
    
    /// Метод для отрисовки нижнего подчеркивания
    private func configureTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: textfield.bounds.height,
                                  width: textfield.bounds.width, height: 1.0)
        bottomLine.backgroundColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
    
    private func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let buttonToolBar = UIBarButtonItem(barButtonSystemItem: .done, target: nil,
                                            action: #selector(datePickerButtonAction))
        toolBar.setItems([buttonToolBar], animated: true)
        dataTextField.inputAccessoryView = toolBar
        dataTextField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = .init(identifier: "English")
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    private func configureAgePickerView() {
        agePickerView.tag = 0
        agePickerView.delegate = self
        agePickerView.dataSource = self
    }
    
    private func configureSexPickerView() {
        sexPickerView.tag = 1
        sexPickerView.delegate = self
        sexPickerView.dataSource = self
    }
}

extension AddDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return 120
        case 1:
            return sex.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return "\(row)"
        case 1:
            return sex[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            ageTextField.text = "\(row)"
        case 1:
            sexTextField.text = sex[row]
        default:
            break
        }
    }
}
