//
//  SecondViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 22.09.22.
//

import UIKit

/// Второй  контроллер
class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var countCustumersTextfield: UITextField!
    @IBOutlet weak var numberTableTextfield: UITextField!
    @IBOutlet weak var bookingTableSwitch: UISwitch!
    @IBOutlet weak var prepaymentSwitch: UISwitch!
    @IBOutlet weak var vipSwitch: UISwitch!
    private var custumer = Custumer()
    private var order = ["Салат Цезарь", "Салат Греческий"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTextField(self.nameTextfield)
        self.configureTextField(self.countCustumersTextfield)
        self.configureTextField(self.numberTableTextfield)
    }
    
    private func configure() {
        self.custumer.name = self.nameTextfield.text ?? "Ошибочный ввод имени"
        self.custumer.count = self.countCustumersTextfield.text ?? ""
        self.custumer.number = self.numberTableTextfield.text ?? ""
        self.custumer.booking = self.bookingTableSwitch.isOn
        self.custumer.prepayment = self.prepaymentSwitch.isOn
        self.custumer.vip = self.vipSwitch.isOn
        configureTextField(self.nameTextfield)
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
    
    @IBAction func bookingActionSwitch(_ sender: UISwitch) {
        self.bookingTableSwitch = sender
    }
    
    @IBAction func prepaymentActionSwitch(_ sender: UISwitch) {
        self.prepaymentSwitch = sender
    }
    
    @IBAction func vipActionSwitch(_ sender: UISwitch) {
        self.vipSwitch = sender
    }
    
    /// Функция выставления счета
    @IBAction func invoiceAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Уходите?", message: "Выставить счет?", preferredStyle: .alert)
        let actionInvoice = UIAlertAction(title: "Счет", style: .default) { [weak self] _ in
            guard let destination = self?.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
                    as? ThirdViewController else { return }
            self?.navigationController?.pushViewController(destination, animated: true)
            self?.configure()
            destination.custumer = self?.nameTextfield.text ?? ""
            destination.tableNumber = self?.numberTableTextfield.text ?? ""
            guard let guests = Int(self?.countCustumersTextfield.text ?? "") else { return }
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
}
