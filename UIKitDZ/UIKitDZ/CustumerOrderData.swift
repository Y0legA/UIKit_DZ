//
//  CustumerOrderData.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 28.09.22.
//

import Foundation

/// Данные для логина и пароля
struct Sequre {
    var login = "8 911 888 88 88"
    var password = "Jack"
}
/// Данные пользователей и логика скидок
struct Custumer {
    let listOfOrders = ["Салат Цезарь": ("Помидор, сыр, оливки, лук, буженина", 400),
                        "Салат Греческий": ("Огурцы, капуста, зелень, приправы, курица, сухарики", 600)
    ]
    var name = ""
    var count = ""
    var number = ""
    var isBooking = false
    var isPrepayment = false
    var isVip = false
    
    func calculateOrder(_ key: String, _ guests: Int) -> (String, String?, Int) {
        let value = self.listOfOrders[key]
        var sum = calculateDiscount(self.isBooking, self.isPrepayment, self.isVip, key)
        sum *= guests
        return (key, value?.0, sum)
    }
    
    private func calculateDiscount(_ booking: Bool, _ prepayment: Bool, _ vip: Bool, _ key: String) -> Int {
        switch (booking, prepayment, vip) {
        case (true, true, true):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 8
        case (true, true, false):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 6
        case (true, false, false):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 7
        case (false, true, false):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 5
        case (false, false, true):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 11
        case (false, false, false):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 8
        case (false, true, true):
            return  Int(self.listOfOrders[key]?.1 ?? 0) / 10 * 9
        case (true, false, true):
            return  Int(self.listOfOrders[key]?.1 ?? 0)
        }
    }
}
