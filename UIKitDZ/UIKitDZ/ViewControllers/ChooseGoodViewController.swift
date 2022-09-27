//
//  ChooseGoodsViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран выбора товара
class ChooseGoodViewController: UIViewController {
    
    private lazy var nameGoodLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Выберите товар"
        label.frame = CGRect(x: 0, y: 30, width: 400, height: 50)
        label.textAlignment = .center
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var goodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: currentKey)
        imageView.frame = CGRect(x: 0, y: nameGoodLabel.frame.maxY, width: view.frame.width, height: view.frame.width)
        imageView.center.x = view.center.x
        return imageView
    }()
    
    private lazy var sizeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: brands)
        segmentedControl.frame = CGRect(x: 0, y: goodImageView.frame.maxY - 30, width: 300, height: 30)
        segmentedControl.addTarget(self, action: #selector(selectedGood(target:)), for: .valueChanged)
        segmentedControl.center.x = view.center.x
        return segmentedControl
    }()
    
    private lazy var choiceCurrentImageSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 0, y: sizeSegmentedControl.frame.minY - 45, width: 100, height: 10)
        slider.addTarget(self, action: #selector(chooseCurrentImage), for: .valueChanged)
        slider.center.x = view.center.x
        return slider
    }()
    
    private lazy var sizeTextField: UITextField = {
        var textField = UITextField()
        textField.inputView = sizesPickerView
        textField.frame = CGRect(x: 20, y: sizeSegmentedControl.frame.maxY + 20,
                                 width: 200, height: 30)
        textField.placeholder = "выберите размер"
        return textField
    }()
    
    private lazy var costGoodLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.frame = CGRect(x: view.frame.width - 250, y: sizeTextField.frame.maxY + 150, width: 200, height: 50)
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0,
                              y: costGoodLabel.frame.maxY,
                              width: sizeSegmentedControl.frame.width,
                              height: 50)
        button.center.x = view.center.x
        button.setTitle("Оформить заказ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buyGood), for: .touchDown)
        return button
    }()
    private let sizesPickerView = UIPickerView()
    private let goods = Goods()
    private lazy var sizes = goods.sizes
    private lazy var brands = goods.collections
    private lazy var goodsKeys = goods.caps.first?.keys
    
    private lazy var cost: String = "" {
        willSet {
            costGoodLabel.text = "Стоимость - \(newValue)p."
        }
    }
    private var currentKey: String = "" {
        willSet {
            goodImageView.image = UIImage(named: newValue)
        }
    }
    private var currentKeys = [""]
    private var currentSegmentedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectedGood(target: UISegmentedControl) {
        if target == sizeSegmentedControl {
            let segmentIndex = target.selectedSegmentIndex
            goodsKeys = goods.caps[segmentIndex].keys
            guard let currentCost = goods.caps[currentSegmentedIndex][currentKey]?.1 else { return }
            cost = String(currentCost)
            configureKeys()
            goodImageView.image = UIImage(named: goods.caps[segmentIndex].first?.key ?? "noAvalible")
            currentSegmentedIndex = segmentIndex
            nameGoodLabel.text = target.titleForSegment(at: segmentIndex)
            target.isMomentary = true
        }
    }
    
    @objc private func chooseCurrentImage(sender: UISlider) {
        if sender == choiceCurrentImageSlider {
            choiceCurrentImageSlider.minimumValue = 0
            choiceCurrentImageSlider.maximumValue = Float(goodsKeys?.count ?? 1) - 1
            currentKey = currentKeys[Int(sender.value)]
        }
    }
    
    @objc private func buyGood() {
        let buyVC = PayViewController()
        buyVC.cost = cost
        navigationController?.pushViewController(buyVC, animated: true)
    }
    
    private func configureUI() {
        view.addSubview(UIImageView(image: UIImage(named: "BackgroundImage")))
        configureKeys()
        view.addSubview(nameGoodLabel)
        view.addSubview(goodImageView)
        view.addSubview(sizeSegmentedControl)
        view.addSubview(sizeTextField)
        view.addSubview(choiceCurrentImageSlider)
        configureSizesPickerView()
        view.addSubview(costGoodLabel)
        view.addSubview(buyButton)
    }
    
    /// метод для настройки текущих ключей при выборе конкретной коллекции
    private func configureKeys() {
        guard let keys = goodsKeys else { return }
        let newKeys = Array(keys)
        currentKeys = newKeys
        guard let key = newKeys.first else { return }
        currentKey = key
    }
    
    private func configureSizesPickerView() {
        sizesPickerView.delegate = self
        sizesPickerView.dataSource = self
    }
}

extension ChooseGoodViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeTextField.text = sizes[row]
        sizeTextField.endEditing(true)
    }
}
