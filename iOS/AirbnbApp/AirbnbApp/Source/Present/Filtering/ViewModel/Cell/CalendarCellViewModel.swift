//
//  CalendarCellViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

final class CalendarCellViewModel {
    private var value: String
    private var isSelected: Bool = false
    
    init(day: FilteringCalendarEntity.Day) {
        if day.value == 0 {
            self.value = ""
        }
        self.value = "\(day.value)"
    }
    
    func getSelection() -> Bool {
        return self.isSelected
    }
    
    func select() {
        self.isSelected.toggle()
    }
    
    func getDay() -> String {
        return value
    }
}
