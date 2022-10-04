//
//  AppViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 3.10.22.
//

import UIKit
// Экран приложения
class AppViewController: UIViewController {
    private enum Constants {
        static let hi = "Привет "
        static let forPay = "Итого к оплате - "
        static let constantInt = ["cost": 0, "components": 1]
        static let forWay = "С собой "
        static let cash = "Оплата наличными"
        static let card = "Оплата картой"
        static let costFuel = [30, 35, 40]
        static let goodsWay = [("кофе", 100), ("чисбургер", 150), ("чай", 70)]
        static let payed = "Оплачено"
        static let goodWay = "Счастливого пути!"
    }
    
    // MARK: - Private Outlet
    @IBOutlet private weak var nameCustumerLabel: UILabel!
    @IBOutlet private weak var resultSumPayLabel: UILabel!
    @IBOutlet private weak var countFuelLabel: UILabel!
    @IBOutlet private weak var goodWayLabel: UILabel!
    @IBOutlet private weak var chooseGoodWay: UIPickerView!
    @IBOutlet private weak var payLabel: UILabel!
    @IBOutlet private weak var cardLabel: UILabel!
    @IBOutlet private weak var cashLabel: UILabel!
    @IBOutlet private weak var cardSwitch: UISwitch!
    @IBOutlet private weak var cashSwitch: UISwitch!
    
    // MARK: - Public Properties
    var nameCustumer = ""
    
    // MARK: - Private Properties
    private var costFuel = Constants.constantInt["cost"]
    private var resultSum = Constants.constantInt["cost"]
    private var textPay = Constants.cash
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private IBAction
    @IBAction private func chooseCountFuelAction(_ sender: UISlider) {
        countFuelLabel.text = String(Int(sender.value))
        resultSum = (costFuel ?? 0) * Int(sender.value)
        resultSumPayLabel.text = "\(Constants.forPay) \(resultSum ?? 0) "
    }
    
    @IBAction private func chooseFuel(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            costFuel = Constants.costFuel[0]
        case 1:
            costFuel = Constants.costFuel[1]
        case 2:
            costFuel = Constants.costFuel[2]
        default:
            return
        }
    }
    
    @IBAction private func cardSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            cashSwitch.setOn(false, animated: true)
            resultSumPayLabel.text = "\(Constants.forPay) \(resultSum ?? 0) \(Constants.card)"
        } else {
            cashSwitch.setOn(true, animated: true)
            resultSumPayLabel.text = "\(Constants.forPay) \(resultSum ?? 0) \(Constants.cash)"
        }
    }
    
    @IBAction private func cashSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            cardSwitch.setOn(false, animated: true)
            resultSumPayLabel.text = "\(Constants.forPay) \(resultSum ?? 0) \(Constants.cash)"
        } else {
            cardSwitch.setOn(true, animated: true)
            resultSumPayLabel.text = "\(Constants.forPay) \(resultSum ?? 0) \(Constants.card)"
        }
    }
    
    @IBAction private func payAction(_ sender: Any) {
        let alertController = UIAlertController(title: Constants.payed,
                                                message: Constants.goodWay,
                                                preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertControllerAction)
        self.present(alertController, animated: true)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        nameCustumerLabel.text = "\(Constants.hi) \(nameCustumer)"
        chooseGoodWay.delegate = self
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AppViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.constantInt["components"] ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.goodsWay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(Constants.goodsWay[row].0)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        goodWayLabel.text = "\(Constants.forWay) \(Constants.goodsWay[row].0)"
        resultSumPayLabel.text = "\(Constants.forPay) \((resultSum ?? 0) + (Constants.goodsWay[row].1))"
    }
}
