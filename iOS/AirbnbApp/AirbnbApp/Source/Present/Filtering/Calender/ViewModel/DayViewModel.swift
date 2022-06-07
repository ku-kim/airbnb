//
//  DayViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

final class DayViewModel {
    
    private var day: String
    private var isSelected: Bool = false
    private var isFirst: Bool = false
    private var isBetween: Bool = false
    
    var isSelectable: Bool {
        if self.day == "" { return false }
        return true
    }
    
    init(day: FilteringCalendarEntity.Day) {
        if day.value == 0 {
            self.day = ""
            return
        }
        self.day = "\(day.value)"
    }
    
}

// MARK: - Providing Function

extension DayViewModel {
    
    func getIsBetween() -> Bool {
        return isBetween
    }
    
    func getIsFirst() -> Bool {
        return isFirst
    }
    
    func getSelection() -> Bool {
        return isSelectable ? isSelected : false
    }
    
    func select(isFirst: Bool) {
        self.isFirst = isFirst
        isSelectable ? isSelected.toggle() : ()
    }
    
    func setBetWeen() {
        isSelectable ? isBetween.toggle() : ()
    }
    
    func getDay() -> String {
        return day
    }
    
}
