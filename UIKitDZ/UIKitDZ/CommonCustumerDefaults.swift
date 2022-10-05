//
//  CommonCustumerDefaults.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 3.10.22.
//

import Foundation
/// Структура для хранения данных
struct CommonCustumerDefaults {
    private enum Keys: String {
        case custumers
    }
    
    private init() {}
    
    static var custumers: [CustumerInfo] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.custumers.rawValue) else { return [] }
            return (try? PropertyListDecoder().decode([CustumerInfo].self, from: data)) ?? []
        }
        set {
            let data = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: Keys.custumers.rawValue)
        }
    }
    
    static func addCustumer(_ custumer: CustumerInfo) {
        var custumers = Self.custumers
        custumers.append(custumer)
        Self.custumers = custumers
    }
}
