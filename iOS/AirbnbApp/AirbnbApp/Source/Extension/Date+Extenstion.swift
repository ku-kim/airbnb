//
//  Date+Extenstion.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) else { return Date()}
            return date
        }
        
    func endOfMonth() -> Date {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) else { return Date()}
        return date
    }
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
