//
//  NumberFormatter+Extension.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/10.
//

import Foundation

extension NumberFormatter {
    static func toPriceUnit(from number: Int) -> String? {
        let nsNumber = NSNumber(value: number)
        let formatter = Self()
        formatter.numberStyle = .decimal
        let formattedNumber = formatter.string(from: nsNumber)
        return formattedNumber
    }
}
