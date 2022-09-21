//
//  ViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Cтартовый контроллер
class ViewController: UIViewController {
    
    private var textLabel = UILabel()
    private var beginButton = UIButton()
    private let text = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Настройка UI
    private func configureUI() {
        view.backgroundColor = .cyan
        view.addSubview(self.textLabel)
        self.textLabel.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.textLabel.textAlignment = .center
        self.textLabel.frame = CGRect(x: 60, y: 50, width: 240, height: 30)
        
        self.view.addSubview(self.beginButton)
        self.beginButton.frame = CGRect(x: 120, y: 100, width: 120, height: 30)
        self.beginButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.beginButton.setTitle("Begin", for: .normal)
        self.beginButton.addTarget(self, action: #selector(startAlert), for: .touchUpInside)
        self.beginButton.layer.cornerRadius = 15
    }
    
    /// Алерт для ввода слова
    @objc func startAlert() {
        let alertController = UIAlertController(title: "", message: "Enter the word", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text  else { return }
            self.textLabel.text = self.text.changeText(text)
        }
        alertController.addTextField()
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}
