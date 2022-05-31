//
//  Int+Extension.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/31.
//

import Foundation

extension Int {
    func convertIntoTime() -> String {
        if self / 60  == 0 {
            return "\(self)분"
        }
        
        let hour = self / 60
        let minute = self % 60
        
        return minute > 30 ? "\(hour + 1) 시간" : "\(Double(hour) + 0.5) 시간"
    }
}
