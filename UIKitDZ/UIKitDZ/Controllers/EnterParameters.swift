//
//  EnterParameters.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 22.09.22.
//

import UIKit

/// Экран выбора параметров
class EnterParameters: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countCustumersTextField: UITextField!
    @IBOutlet weak var numberTableTextField: UITextField!
    @IBOutlet weak var bookingTableSwitch: UISwitch!
    @IBOutlet weak var prepaymentSwitch: UISwitch!
    @IBOutlet weak var vipSwitch: UISwitch!
    private var custumer = Custumer()
    private var order = ["Салат Цезарь", "Салат Греческий"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    @IBAction func bookingActionSwitchAction(_ sender: UISwitch) {
        self.bookingTableSwitch = sender
    }
    
    @IBAction func prepaymentActionSwitchAction(_ sender: UISwitch) {
        self.prepaymentSwitch = sender
    }
    
    @IBAction func vipActionSwitchAction(_ sender: UISwitch) {
        self.vipSwitch = sender
    }
    
    /// Функция выставления счета
    @IBAction func invoiceAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Уходите?", message: "Выставить счет?", preferredStyle: .alert)
        let actionInvoice = UIAlertAction(title: "Счет", style: .default) { [weak self] _ in
            guard let destination = self?.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
                    as? ShowCheck else { return }
            self?.navigationController?.pushViewController(destination, animated: true)
            self?.configureParametersProperties()
            destination.custumer = self?.nameTextField.text ?? ""
            destination.tableNumber = self?.numberTableTextField.text ?? ""
            guard let guests = Int(self?.countCustumersTextField.text ?? "") else { return }
            var dish = (self?.custumer.calculateOrder(self?.order[0] ?? (""), guests))
            destination.firstDish = dish?.0 ?? ""
            destination.descriptionFirstDish = dish?.1 ?? ""
            var sum = dish?.2 ?? 0
            destination.costFirstPosition = "\(sum)"
            dish = (self?.custumer.calculateOrder(self?.order[1] ?? (""), guests))
            destination.secondDish = dish?.0 ?? ""
            destination.descriptionSecondDish = dish?.1 ?? ""
            destination.costSecondPosition = "\(dish?.2 ?? 0)"
            sum += dish?.2 ?? 0
            destination.sum = String(sum)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(actionCancel)
        alertController.addAction(actionInvoice)
        self.present(alertController, animated: true)
    }
    
    private func configureUI() {
        self.configureTextField(self.nameTextField)
        self.configureTextField(self.countCustumersTextField)
        self.configureTextField(self.numberTableTextField)
    }
    
    private func configureParametersProperties() {
        self.custumer.name = self.nameTextField.text ?? "Ошибочный ввод имени"
        self.custumer.count = self.countCustumersTextField.text ?? ""
        self.custumer.number = self.numberTableTextField.text ?? ""
        self.custumer.isBooking = self.bookingTableSwitch.isOn
        self.custumer.isPrepayment = self.prepaymentSwitch.isOn
        self.custumer.isVip = self.vipSwitch.isOn
        configureTextField(self.nameTextField)
    }
    
    private func configureTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: textfield.bounds.height,
                                  width: textfield.bounds.width - 1, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
}
