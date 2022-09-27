//
//  Extentions.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 26.09.22.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Метод для отрисовки нижнего подчеркивания
    func configureTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: textfield.bounds.height,
                                  width: textfield.bounds.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
}
