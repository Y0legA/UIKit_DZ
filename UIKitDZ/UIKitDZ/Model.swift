//
//  Model.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 22.09.22.
//

import Foundation

/// модель
struct Model {
    var text: String?
    
    func changeText(_ text: String?) -> String? {
        text == "leohl" ? "hello" : text
    }
}
