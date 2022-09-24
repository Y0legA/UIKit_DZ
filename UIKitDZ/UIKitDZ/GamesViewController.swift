//
//  GamesViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран ввода имени, расчета суммы, с игрой "Угадай число"
class GamesViewController: UIViewController {
    
    private var nameLabel = UILabel()
    private var resultSumLabel = UILabel()
    private var guessNumberLabel = UILabel()
    private var guessNumberTextField = UITextField()
    private var tryGuessNumberButton = UIButton()
    private var guessNumberStartGameButton = UIButton()
    private var sumButton = UIButton()
    private var randomNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Настройка UI
    private func configureUI() {
        configureNameLabel()
        configureGuestNumberTextField()
        confifureGuessNumberStartGameButton()
        configureTryGuessNumberButton()
        configureResultSumNumber()
        configureNumberButton()
    }
    
    private func configureNameLabel() {
        view.addSubview(self.nameLabel)
        self.nameLabel.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.nameLabel.textAlignment = .center
        self.nameLabel.frame = CGRect(x: 60, y: 50, width: 240, height: 30)
    }
    
    private func configureGuestNumberTextField() {
        self.view.addSubview(self.guessNumberTextField)
        self.guessNumberTextField.text = "1"
        self.guessNumberTextField.frame = CGRect(x: 230, y: 150, width: 80, height: 30)
        self.guessNumberTextField.textAlignment = .center
        self.guessNumberTextField.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    private func confifureGuessNumberStartGameButton() {
        self.view.addSubview(self.guessNumberStartGameButton)
        self.guessNumberStartGameButton.frame = CGRect(x: 60, y: 200, width: 120, height: 30)
        self.guessNumberStartGameButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.guessNumberStartGameButton.setTitle("start game", for: .normal)
        self.guessNumberStartGameButton.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        self.guessNumberStartGameButton.layer.cornerRadius = 15
    }
    
    private func configureTryGuessNumberButton() {
        self.view.addSubview(self.tryGuessNumberButton)
        self.tryGuessNumberButton.frame = CGRect(x: 220, y: 200, width: 80, height: 30)
        self.tryGuessNumberButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.tryGuessNumberButton.setTitle("try", for: .normal)
        self.tryGuessNumberButton.addTarget(self, action: #selector(tryGuessAction), for: .touchUpInside)
        self.tryGuessNumberButton.layer.cornerRadius = 15
    }
    
    private func configureResultSumNumber() {
        self.view.addSubview(self.resultSumLabel)
        self.resultSumLabel.frame = CGRect(x: 120, y: 500, width: 150, height: 30)
    }
    
    private func configureNumberButton() {
        self.view.addSubview(self.sumButton)
        self.sumButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.sumButton.setTitle("calculate", for: .normal)
        self.sumButton.layer.cornerRadius = 15
        self.sumButton.addTarget(self, action: #selector(alertNumberingNumbersAlert), for: .touchUpInside)
        self.sumButton.frame = CGRect(x: 135, y: 460, width: 100, height: 30)
    }
    
    /// Приглашение ввода ФИО при запуске приложения
    private func startAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Show", style: .default) { _ in
            let name = alertController.textFields?.first?.text
            guard let empty = name?.isEmpty else { return }
            empty ? (self.nameLabel.text = "No name") : (self.nameLabel.text =  (name ?? ""))
        }
        alertController.addTextField()
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    /// Метод для обработки вводимых чисел
    @objc func alertNumberingNumbersAlert() {
        let alertController = UIAlertController(title: "Sum", message: "Enter the numbers...",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Calculate", style: .default) { _ in
            let numOne = (alertController.textFields?[0].text ?? "")
            let numTwo = (alertController.textFields?[1].text ?? "")
            guard let numOne = Int(numOne), let numTwo = Int(numTwo) else { return }
            self.resultSumLabel.text = "Result of sum - \(numOne + numTwo)"
        }
        alertController.addTextField { textfild in
            textfild.placeholder = "Enter first number"
        }
        alertController.addTextField { textfild in
            textfild.placeholder = "Enter second number"
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    /// Игра "Угадай число"
    private func guessNumber() {
        self.guessNumberLabel.text = "GUESS NUMBER"
        
        guard let userNumber = Int(self.guessNumberTextField.text ?? "") else {
            return self.guessNumberTextField.text = "no correct enter"
        }
        
        switch userNumber {
        case let num where num == randomNumber:
            self.guessNumberLabel.text = "YOU WIN!!!"
            self.guessNumberStartGameButton.isUserInteractionEnabled = true
            self.guessNumberStartGameButton.isHidden = false
        case 0..<randomNumber:
            self.guessNumberLabel.text = "Too small number"
        case randomNumber..<250:
            self.guessNumberLabel.text = "Too big number"
            
        default:
            break
        }
    }
    
    /// Запуск игры "Угадай число"
    @objc func startGameAction() {
        self.randomNumber = Int.random(in: 1...250)
        self.guessNumberStartGameButton.isUserInteractionEnabled = false
        self.guessNumberStartGameButton.isHidden = true
    }
    
    /// Попытка угадать число
    @objc func tryGuessAction() {
        self.guessNumber()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startAlert(title: "Hello!", message: "Enter your SNL...")
    }
}
