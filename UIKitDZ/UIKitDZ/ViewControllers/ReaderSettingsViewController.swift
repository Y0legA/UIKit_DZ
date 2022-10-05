//
//  ReaderSettingsViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 4.10.22.
//

import UIKit
// Меню настроек ридера
final class ReaderSettingsViewController: UIViewController {
    private enum ButtonKind: String {
        case blackColor
        case whiteColor
        case redColor
        case grayColor
    }
    
    private enum Constants {
        static let changeFone = "Сменить фон"
        static let fontSizeText = "Размер шрифта"
        static let fontThicknessText = "Толщина шрифта"
        static let chevronDown = "chevron.down"
        static let chevronUp = "chevron.up"
        static let nameFonts = ["Arial",
                                "Times New Roman",
                                "Charter Roman",
                                "Courier New",
                                "Helvetica"]
        static let fontText = "Шрифт"
    }
    
    // MARK: - Public Properties
    var backColorHandler: ((SettingsTextReader)->())?
    var settingsTextReader = SettingsTextReader()
    
    // MARK: Private Visual Components
    private lazy var settingsUnderscoreView = makeUnderscore(yCoordinate: 20)
    private lazy var colorTextUnderscoreView = makeUnderscore(yCoordinate: 70)
    private lazy var sizeTextUnderscoreView = makeUnderscore(yCoordinate: 150)
    private lazy var boldTextUnderscoreView = makeUnderscore(yCoordinate: 230)
    private lazy var fontTextUnderscoreView = makeUnderscore(yCoordinate: 290)
    
    private lazy var blackColorTextButton = makeColorTextButton(coordinateX: 50, backgroundColor: .black)
    private lazy var whiteColorTextButton = makeColorTextButton(coordinateX: 130, backgroundColor: .white)
    private lazy var redColorTextButton = makeColorTextButton(coordinateX: 210, backgroundColor: .red)
    private lazy var grayColorTextButton = makeColorTextButton(coordinateX: 290, backgroundColor: .gray)
    
    private lazy var themeSwitch: UISwitch = {
        let temaSwitch = UISwitch()
        temaSwitch.frame = CGRect(x: 300, y: view.frame.minY + 30, width: 40, height: 40)
        temaSwitch.addTarget(self, action: #selector(temaSwitchAction), for: .valueChanged)
        return temaSwitch
    }()
    
    private lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 0, y: 190, width: 300, height: 30)
        slider.center.x = view.center.x
        slider.minimumValue = 10
        slider.maximumValue = 40
        slider.value = 20
        slider.addTarget(self, action: #selector(fontSizeSliderAction), for: .valueChanged)
        return slider
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 20, y: 30, width: 40, height: 40)
        btn.setImage(UIImage(systemName: Constants.chevronDown), for: .normal)
        btn.tintColor =   #colorLiteral(red: 0.6602165699, green: 0.8063992858, blue: 1, alpha: 1)
        btn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingsView: UIView = {
        let settingsView = UIView()
        settingsView.frame = CGRect(x: 0, y: view.frame.minY, width: view.frame.width, height: 700)
        settingsView.layer.cornerRadius = 15
        return settingsView
    }()
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.changeFone
        label.textColor = #colorLiteral(red: 0.09086550027, green: 0.1191550866, blue: 0.4654941559, alpha: 1)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: view.frame.minY + 30, width: view.frame.width, height: 30)
        return label
    }()
    
    private lazy var fontSizeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.fontSizeText
        label.textColor = #colorLiteral(red: 0.09086550027, green: 0.1191550866, blue: 0.4654941559, alpha: 1)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 160, width: view.frame.width, height: 30)
        return label
    }()
    
    private lazy var fontThicknessLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.fontThicknessText
        label.textColor = #colorLiteral(red: 0.09086550027, green: 0.1191550866, blue: 0.4654941559, alpha: 1)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 245, width: 150, height: 30)
        return label
    }()
    
    private lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.fontText
        label.textColor = #colorLiteral(red: 0.09086550027, green: 0.1191550866, blue: 0.4654941559, alpha: 1)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: 30)
        return label
    }()
    
    private lazy var boldFontButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 320, y: 245, width: 40, height: 40)
        btn.setImage(UIImage(systemName: Constants.chevronUp), for: .normal)
        btn.tintColor =   #colorLiteral(red: 0.6602165699, green: 0.8063992858, blue: 1, alpha: 1)
        btn.addTarget(self, action: #selector(boldFontButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var thinFontButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 250, y: 245, width: 40, height: 40)
        btn.setImage(UIImage(systemName: Constants.chevronDown), for: .normal)
        btn.tintColor =   #colorLiteral(red: 0.6602165699, green: 0.8063992858, blue: 1, alpha: 1)
        btn.addTarget(self, action: #selector(thinFontButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var fountPickerView: UIPickerView = {
        let fountPicker = UIPickerView()
        fountPicker.delegate = self
        fountPicker.dataSource = self
        fountPicker.frame = CGRect(x: 0, y: 310, width: view.frame.width, height: 110)
        return fountPicker
    }()
    
    // MARK: - Private Properties
    private var fontWeights: [UIFont.Weight] = [.ultraLight, .light, .regular, .semibold, .bold]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        colorButtonIdentifier()
    }
    
    // MARK: - Private Action
    @objc private func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func boldFontButtonAction() {
        let current = settingsTextReader.fontWeight
        guard let index = fontWeights.firstIndex(where: { $0 == current }) else { return }
        if index + 1 < fontWeights.count {
            settingsTextReader.fontWeight = fontWeights[index + 1]
            backColorHandler?(settingsTextReader)
        } else {
            settingsTextReader.fontWeight = fontWeights[index]
            backColorHandler?(settingsTextReader)
        }
    }
    
    @objc private func thinFontButtonAction() {
        let current = settingsTextReader.fontWeight
        guard let index = fontWeights.firstIndex(where: { $0 == current }) else { return }
        if index >= 1 {
            settingsTextReader.fontWeight = fontWeights[index - 1]
            backColorHandler?(settingsTextReader)
        } else {
            settingsTextReader.fontWeight = fontWeights[index]
            backColorHandler?(settingsTextReader)
        }
    }
    
    @objc private func colorTextButtonAction(_ sender: UIButton) {
        switch sender.accessibilityIdentifier {
        case ButtonKind.blackColor.rawValue:
            settingsTextReader.color = .black
            backColorHandler?(settingsTextReader)
        case ButtonKind.whiteColor.rawValue:
            settingsTextReader.color = .white
            backColorHandler?(settingsTextReader)
        case ButtonKind.redColor.rawValue:
            settingsTextReader.color = .red
            backColorHandler?(settingsTextReader)
        case ButtonKind.grayColor.rawValue:
            settingsTextReader.color = .gray
            backColorHandler?(settingsTextReader)
        default:
            break
        }
    }
    
    @objc private func fontSizeSliderAction(_ sender: UISlider) {
        settingsTextReader.sizeFont = CGFloat(sender.value)
        backColorHandler?(settingsTextReader)
    }
    
    @objc private func temaSwitchAction() {
        if themeSwitch.isOn {
            settingsTextReader.readerBackground = .black
            settingsTextReader.color = .white
            backColorHandler?(settingsTextReader)
        } else {
            settingsTextReader.readerBackground = .white
            settingsTextReader.color = .black
            backColorHandler?(settingsTextReader)
        }
    }
    
    // MARK: - Private Methods
    private func colorButtonIdentifier() {
        blackColorTextButton.accessibilityIdentifier = ButtonKind.blackColor.rawValue
        whiteColorTextButton.accessibilityIdentifier = ButtonKind.whiteColor.rawValue
        redColorTextButton.accessibilityIdentifier = ButtonKind.redColor.rawValue
        grayColorTextButton.accessibilityIdentifier = ButtonKind.grayColor.rawValue
    }
    
    private func makeUnderscore(yCoordinate: CGFloat) -> UIView {
        let underscore = UIView()
        underscore.backgroundColor = #colorLiteral(red: 0.6602165699, green: 0.8063992858, blue: 1, alpha: 1)
        underscore.frame = CGRect(x: 0, y: yCoordinate, width: view.frame.width, height: 1)
        return underscore
    }
    
    private func makeColorTextButton(coordinateX: Int, backgroundColor: UIColor) -> UIButton {
        let btn = UIButton()
        btn.backgroundColor = backgroundColor
        btn.frame = CGRect(x: coordinateX, y: 85, width: 50, height: 50)
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(colorTextButtonAction), for: .touchUpInside)
        return btn
    }
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(settingsView)
        view.addSubview(settingsLabel)
        view.addSubview(settingsUnderscoreView)
        view.addSubview(backButton)
        view.addSubview(blackColorTextButton)
        view.addSubview(whiteColorTextButton)
        view.addSubview(redColorTextButton)
        view.addSubview(grayColorTextButton)
        view.addSubview(fontSizeSlider)
        view.addSubview(colorTextUnderscoreView)
        view.addSubview(fontSizeLabel)
        view.addSubview(sizeTextUnderscoreView)
        view.addSubview(fontThicknessLabel)
        view.addSubview(boldFontButton)
        view.addSubview(thinFontButton)
        view.addSubview(boldTextUnderscoreView)
        view.addSubview(fountPickerView)
        view.addSubview(fontLabel)
        view.addSubview(fontTextUnderscoreView)
        view.addSubview(themeSwitch)
    }
}

    // MARK: - UIPickerViewDelegate
extension ReaderSettingsViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Constants.nameFonts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.nameFonts[row]
    }
}
    // MARK: - UIPickerViewDataSource
extension ReaderSettingsViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settingsTextReader.nameFont = Constants.nameFonts[row]
        backColorHandler?(settingsTextReader)
    }
}
