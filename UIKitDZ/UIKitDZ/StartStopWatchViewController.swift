//
//  StartStopWatchViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

// Экран секундомера
final class StartStopWatchViewController: UIViewController {
    enum Constants {
        static let start = "Старт"
        static let stop = "Стоп"
        static let reset = "Сброс"
        static let countZero = 0
        static let count = 60
        static let formatter = "%02d"
    }
    
    // MARK: - Private IBOutlet
    @IBOutlet private weak var startStopLabel: UILabel!
    @IBOutlet private weak var startStopButton: UIButton!
    
    // MARK: - Private Properties
    private var timer = Timer()
    private var count = Constants.countZero
    private var isTapped = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private IBAction
    @IBAction private func startStopAction(_ sender: Any) {
        isTapped.toggle()
        guard isTapped == true else {
            startStopButton.setTitle(Constants.start, for: .normal)
            timer.invalidate()
            return
        }
        startStopButton.setTitle(Constants.stop, for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(updateValueAction),
                                     userInfo: nil, repeats: true)
    }
    
    @IBAction private func resetAction(_ sender: UIButton) {
        startStopLabel.text = makeTimeString(Constants.countZero, Constants.countZero, Constants.countZero)
        count = Constants.countZero
        startStopButton.setTitle(Constants.start, for: .normal)
        isTapped = false
        timer.invalidate()
    }
    
    @objc private func updateValueAction() {
        count += 1
        let time = convert(count)
        let timeString = makeTimeString(time.0, time.1, time.2)
        startStopLabel.text = timeString
    }
    
    // MARK: - Private Properties
    private func convert(_ seconds: Int) -> (Int, Int, Int) {
        return ((seconds / Constants.count * Constants.count),
                ((seconds % (Constants.count * Constants.count)) / Constants.count),
                ((seconds % (Constants.count * Constants.count)) % Constants.count))
    }
    
    private func makeTimeString(_ hour: Int, _ minutes: Int, _ seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: Constants.formatter, hour)
        timeString += ":"
        timeString += String(format: Constants.formatter, minutes)
        timeString += ":"
        timeString += String(format: Constants.formatter, seconds)
        return timeString
    }
}
