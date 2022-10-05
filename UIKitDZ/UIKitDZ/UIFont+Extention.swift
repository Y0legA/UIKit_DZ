//
//  Extention+UIFont.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 5.10.22.
//

import UIKit
///  Расширение для изменения толщины текста
extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }

    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        traits[.weight] = weight
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
