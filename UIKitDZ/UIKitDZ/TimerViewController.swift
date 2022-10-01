//
//  TimerViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 1.10.22.
//

import UIKit

/// Экран таймера
final class TimerViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var timerPickerView: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods
    private func configureUI() {
        timerPickerView.delegate = self
        timerPickerView.dataSource = self
        cancelButton.layer.borderColor = #colorLiteral(red: 0.129522278, green: 0.129522278, blue: 0.129522278, alpha: 1)
        startButton.layer.borderColor = #colorLiteral(red: 0.04249797016, green: 0.1647131443, blue: 0.06017308682, alpha: 1)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        case 2:
            return "\(row)"
        default:
            return ""
        }
    }
}
