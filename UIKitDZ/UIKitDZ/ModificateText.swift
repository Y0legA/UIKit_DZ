//
//  Model.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 22.09.22.
//

import Foundation

/// Модель передаваемых данных
struct ModificateText {
    var text: String?
    
    func changeText(_ text: String?) -> String? {
        text == "leohl" ? "hello" : text
    }
}
