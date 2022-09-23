//
//  ThirdViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 22.09.22.
//

import UIKit

/// Третий контроллер
class ThirdViewController: UIViewController {
    
    var custumer = ""
    var tableNumber = ""
    var firstDish = ""
    var costFirstPosition = ""
    var descriptionFirstDish = ""
    var secondDish = ""
    var costSecondPosition = ""
    var descriptionSecondDish = ""
    var sum = ""
    
    @IBOutlet weak var custumerLabel: UILabel!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var firstDishLabel: UILabel!
    @IBOutlet weak var costFirstDishLabel: UILabel!
    @IBOutlet weak var descriptionFirstDishLabel: UILabel!
    @IBOutlet weak var secondDishLabel: UILabel!
    @IBOutlet weak var costSecondDishLabel: UILabel!
    @IBOutlet weak var descriptionSecondDishLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    private func configureData() {
        self.custumerLabel.text = self.custumer
        self.tableNumberLabel.text = tableNumber
        self.firstDishLabel.text = firstDish
        self.costFirstDishLabel.text = costFirstPosition + " p >"
        self.descriptionFirstDishLabel.text = descriptionFirstDish
        self.secondDishLabel.text = secondDish
        self.costSecondDishLabel.text = costSecondPosition + " p >"
        self.descriptionSecondDishLabel.text = descriptionSecondDish
        self.sumLabel.text = sum
        configureTextField(self.descriptionFirstDishLabel)
        configureTextField(self.descriptionSecondDishLabel)
    }
    
    private func configureTextField(_ label: UILabel) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: label.bounds.height,
                                  width: label.bounds.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.layer.addSublayer(bottomLine)
    }
}
