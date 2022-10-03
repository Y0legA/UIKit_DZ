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
    @IBOutlet weak private var timerPickerView: UIPickerView!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var startButton: UIButton!
    
    // MARK: - Private Properties
    private var timer: Timer?
    private let hours = Array(0...23)
    private let min = Array(0...59)
    private let sec = Array(0...59)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - IBActions
    @IBAction private func startAction(_ sender: Any) {
        timerToggle()
    }
    
    @IBAction private func stopAction(_ sender: Any) {
        timer?.invalidate()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        timerPickerView.delegate = self
        timerPickerView.dataSource = self
        cancelButton.layer.borderColor = #colorLiteral(red: 0.129522278, green: 0.129522278, blue: 0.129522278, alpha: 1)
        startButton.layer.borderColor = #colorLiteral(red: 0.04249797016, green: 0.1647131443, blue: 0.06017308682, alpha: 1)
    }
    
    private func timerToggle() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [ weak self ] _ in
            guard let self = self else { return }
            let hour = self.timerPickerView.selectedRow(inComponent: 0)
            let min = self.timerPickerView.selectedRow(inComponent: 1)
            let sec = self.timerPickerView.selectedRow(inComponent: 2)
            self.timerPickerView.selectRow(sec - 1, inComponent: 2, animated: true)
            switch (hour, min, sec) {
            case (0, 0, 0):
                self.timer?.invalidate()
            case (0...23, 0, 0):
                if let minEnd = self.min.last,
                   let secEnd = self.sec.last {
                    self.timerPickerView.selectRow(minEnd, inComponent: 1, animated: true)
                    self.timerPickerView.selectRow(secEnd, inComponent: 2, animated: true)
                    self.timerPickerView.selectRow(hour - 1, inComponent: 0, animated: true)
                }
            case (0...23, 0...59, 0):
                if let secEnd = self.sec.last {
                    self.timerPickerView.selectRow(secEnd, inComponent: 2, animated: true)
                    self.timerPickerView.selectRow(min - 1, inComponent: 1, animated: true)
                }
            default:
                break
            }
        })
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
            return hours.count
        case 1:
            return min.count
        case 2:
            return sec.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hours[row].description
        case 1:
            return min[row].description
        case 2:
            return sec[row].description
        default:
            return ""
        }
    }
}
