//
//  ActivityViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран шаринга
class ActivityViewController: UIViewController {
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var sendImageView: UIImageView!
    private let pickerItems = ["Поменять цвет view", "Передачa текста в urlLabel", "SHARE"]
    
    private var activityViewController: UIActivityViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func shareAction() { sharingByButton() }
    
    @objc private func sharingByButton() {
        guard let item = sendImageView.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    private func sharingByPicker() {
        guard let link = URL(string: "https://mylink.com"), let text = urlLabel.text else { return }
        activityViewController = UIActivityViewController(activityItems: [text, link], applicationActivities: nil)
        urlLabel.text = "\(link)"
        guard let activityViewController = self.activityViewController else { return }
        present(activityViewController, animated: true, completion: nil)
    }
}

/// Расширение для реализации функций делегата и датасорса UIPicker
extension ActivityViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            guard view.backgroundColor == .orange else { return view.backgroundColor = .orange }
            view.backgroundColor = .cyan
        case 1:
            urlLabel.text = pickerItems[row]
        case 2:
            sharingByPicker()
        default:
            break
        }
    }
}
