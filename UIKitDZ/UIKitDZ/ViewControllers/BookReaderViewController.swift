//
//  BookReaderViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 4.10.22.
//

import UIKit

// Экран выбранной книги
final class BookReaderViewController: UIViewController {
    // MARK: - Public Properties
    var settingsTextReader = SettingsTextReader()
    var bookName = ""
    var textBook = ""
    
    // MARK: - Private Visual Components
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: view.frame.maxY - 70, width: view.frame.width, height: 70)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var readerTextView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 0,
                                y: view.frame.minY + 100,
                                width: view.frame.width,
                                height: view.frame.height - 170)
        textView.text = textBook
        return textView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Action
    @objc private func settingsButtonAction() {
        let readerSettingsVC = ReaderSettingsViewController()
        readerSettingsVC.modalPresentationStyle = .pageSheet
        if let sheet = readerSettingsVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        readerSettingsVC.settingsTextReader = settingsTextReader
        readerSettingsVC.backColorHandler = { [weak self ] in
            self?.handleChanges($0)
        }
        present(readerSettingsVC, animated: true)
        
    }
    
    // MARK: - Private Methods
    private func handleChanges(_ settings: SettingsTextReader) {
        readerTextView.textColor = settings.color
        readerTextView.font = UIFont(name: settings.nameFont, size: settings.sizeFont)?.withWeight(settings.fontWeight)
        readerTextView.backgroundColor = settings.readerBackground
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = bookName
        view.addSubview(settingsButton)
        view.addSubview(readerTextView)
    }
}
