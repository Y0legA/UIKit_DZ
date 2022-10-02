//
//  ViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран выбора настроек ввода текста
final class SetupTextViewController: UIViewController {
    private enum Constants {
        static let eddedText = "Нажмите +"
        static let chooseSizeText = "Выберите размер шрифта"
        static let currentSizeText = "Текущий размер шрифта - "
        static let currentSizeFont = 15
        static let chooseColorText = "Выберите цвет шрифта"
        static let colors: [UIColor] = [.green, .black, .systemMint, .blue, .brown,
                                                .red, .link, .gray, .orange, .purple
                                        ]
        static let chooseCountLinesText = "Выберите количество строк"
        static let currentCountLinesText = "Текущее количество строк - "
        static let lines = Array(0...10)
    }
    
    // MARK: - Visual Components
    private lazy var eddedTextLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20,
                             y: 100,
                             width: view.frame.width - 40,
                             height: view.frame.height / 3)
        label.text = Constants.eddedText
        label.numberOfLines = Constants.lines.first ?? 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byCharWrapping
        label.backgroundColor = #colorLiteral(red: 0.5683856971, green: 0.9671003285, blue: 1, alpha: 1)
        label.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    private lazy var changeSizeTextSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 0, y: eddedTextLabel.frame.maxY + 10, width: view.frame.width / 3 * 2, height: 30)
        slider.center.x = view.center.x
        slider.minimumValue = 10
        slider.maximumValue = 50
        slider.value = 15
        slider.addTarget(self, action: #selector(changeSizeTextAction), for: .valueChanged)
        return slider
    }()
    
    private lazy var chooseSizeTextLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.chooseSizeText
        label.frame = CGRect(x: 0,
                             y: changeSizeTextSlider.frame.maxY,
                             width: changeSizeTextSlider.frame.width,
                             height: 30)
        label.textAlignment = .center
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var currentSizeFontTextLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.currentSizeText) \(Constants.currentSizeFont)"
        label.frame = CGRect(x: view.frame.width / 3,
                             y: chooseSizeTextLabel.frame.maxY,
                             width: view.frame.width - 150,
                             height: 30)
        label.textAlignment = .center
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var currentCountLinesLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.currentCountLinesText) \(Constants.lines.first ?? 0)"
        label.frame = CGRect(x: 0, y: currentSizeFontTextLabel.frame.maxY + 50, width: 300, height: 30)
        label.center.x = view.center.x
        return label
    }()
    
    private lazy var chooseCountLinesLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.chooseCountLinesText)"
        label.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        label.frame = CGRect(x: currentCountLinesLabel.frame.minX,
                             y: currentCountLinesLabel.frame.maxY,
                             width: 300,
                             height: 30)
        return label
    }()
    
    private lazy var countTextLinesPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 1
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        picker.frame = CGRect(x: view.frame.width - 100, y: 0, width: 70, height: 150)
        picker.center.y = chooseCountLinesLabel.center.y
        return picker
    }()
    
    private lazy var chooseColorLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.chooseColorText
        label.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        label.frame = CGRect(x: chooseCountLinesLabel.frame.minX, y: view.frame.maxY - 250, width: 200, height: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var chooseColorPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 0
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        picker.frame = CGRect(x: 0, y: chooseColorLabel.frame.maxY, width: chooseColorLabel.frame.width, height: 100)
        picker.center.x = chooseColorLabel.center.x
        return picker
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - IBAction
    @objc private func addTextAction() {
        let alertViewController = UIAlertController(title: "Введите текст", message: nil, preferredStyle: .alert)
        alertViewController.addTextField()
        alertViewController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertViewController.addAction(UIAlertAction(title: "Ввод", style: .default, handler: { text in
            self.eddedTextLabel.text = alertViewController.textFields?.first?.text
        }))
        present(alertViewController, animated: true)
    }
    
    @objc private func changeSizeTextAction(_ sender: UISlider) {
        eddedTextLabel.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
        currentSizeFontTextLabel.text = "\(Constants.currentSizeText) \(Int(sender.value))"
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureView()
        configureNavigationBar()
        configureTabBar()
    }
    
    private func configureView() {
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(eddedTextLabel)
        view.addSubview(changeSizeTextSlider)
        view.addSubview(chooseSizeTextLabel)
        view.addSubview(currentSizeFontTextLabel)
        view.addSubview(chooseColorPickerView)
        view.addSubview(chooseColorLabel)
        view.addSubview(chooseCountLinesLabel)
        view.addSubview(countTextLinesPickerView)
        view.addSubview(currentCountLinesLabel)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .cyan
        navigationItem.title = "Setup text"
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTextAction))
        addButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = addButtonItem
    }
    
    private func configureTabBar() {
        tabBarController?.tabBar.backgroundColor = .cyan
        tabBarController?.tabBarItem.standardAppearance?.backgroundColor = .black
        let tabBarItem = UITabBarItem(title: "Set text properties",
                                      image: UIImage(systemName: "text.badge.checkmark"), tag: 0)
        tabBarController?.tabBar.tintColor = .black
        self.tabBarItem = tabBarItem
    }
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension SetupTextViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return Constants.colors.count
        case 1:
            return Constants.lines.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return Constants.colors[row].accessibilityName
        case 1:
            return "\(Constants.lines[row])"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            chooseColorLabel.tintColor = Constants.colors[row]
            eddedTextLabel.textColor = Constants.colors[row]
        case 1:
            eddedTextLabel.numberOfLines = row
            currentCountLinesLabel.text = "\(Constants.currentCountLinesText) \(row)"
        default:
            break
        }
    }
}
