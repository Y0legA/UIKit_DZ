//
//  BirthdayViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 23.09.22.
//

import UIKit

/// Экран для отображения дней рождения
class BirthdayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc private func showDetailsAction() {
        let detailsVC = AddDetailsViewController()
        detailsVC.modalTransitionStyle = .flipHorizontal
        present(detailsVC, animated: true)
    }
    
    private func configureUI() {
        configureSelfView()
        configureBlock(CGPoint(x: 10, y: 100), "Jeremy", days: "18 дней", "10 марта, в среду, исполнится 25 лет")
        configureBlock(CGPoint(x: 10, y: 200), "Maria Lui", days: "28 дней", "30 марта, в четверг, исполнится 25 лет")
        configureBlock(CGPoint(x: 10, y: 300), "Jony Stark", days: "53 дней", "20 апреля, в субботу, исполнится 25 лет")
    }
    
    private func configureSelfView() {
        view.backgroundColor = .white
        navigationItem.title = "Birthday"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(showDetailsAction))
    }
    
    /// Метод для настройки каждой записи
    private func configureBlock(_ origin: CGPoint, _ name: String, days: String, _ description: String) {
        let image = createImageView(origin)
        let name = createNameLabel(CGPoint(x: image.frame.maxX, y: image.frame.minY), name)
        let day = createDayLabel(CGPoint(x: view.bounds.maxX - 80, y: name.frame.minY), days)
        let descriptionIvent = createDescriptionIventLabel(CGPoint(x: image.frame.maxX, y: name.frame.maxY),
                                                           description)
        configureBorderLine(descriptionIvent)
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(day)
        view.addSubview(descriptionIvent)
    }
    
    private func createImageView(_ origin: CGPoint) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person")
        imageView.tintColor = .lightGray
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.frame.origin = origin
        return imageView
    }
    
    private func createNameLabel(_ origin: CGPoint, _ name: String) -> UILabel {
        let label = UILabel()
        label.frame.size = CGSize(width: 100, height: 30)
        label.frame.origin = origin
        label.text = name
        label.font = UIFont.init(name: "Avenir Next Demi Bold", size: 20)
        return label
    }
    
    private func createDayLabel(_ origin: CGPoint, _ name: String) -> UILabel {
        let label = UILabel()
        label.tintColor = .lightGray
        label.frame.size = CGSize(width: 100, height: 30)
        label.frame.origin = origin
        label.text = name
        label.font = UIFont.init(name: "Avenir Next", size: 15)
        label.textColor = .systemGray
        return label
    }
    
    private func createDescriptionIventLabel(_ origin: CGPoint, _ name: String) -> UILabel {
        let label = UILabel()
        label.tintColor = .lightGray
        label.frame.size = CGSize(width: view.bounds.width - 90, height: 30)
        label.frame.origin = origin
        label.text = name
        label.font = UIFont.init(name: "Avenir Next", size: 15)
        label.textColor = .systemGray
        return label
    }
    
    /// Метод для отрисовки нижнего подчеркивания
    private func configureBorderLine(_ label: UILabel) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: label.bounds.height,
                                  width: label.bounds.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.layer.addSublayer(bottomLine)
    }
}
