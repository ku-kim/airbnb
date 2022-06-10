//
//  MonthViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

final class MonthViewModel {
    
    private var cellViewModels: [DayViewModel] = []
    private var lastWeekDay: Int = 0
    private var firstWeekDay: Int = 0
    private var year: Int = 0
    private var month: Int = 0
    
    var count: Int {
        return cellViewModels.count
    }
    
    init(month: FilteringCalendarEntity.Month) {
        var viewModels: [DayViewModel] = []
        for day in 2...month.totalDay {
            if day < month.firstWeekDay {
                viewModels.append(DayViewModel(day: FilteringCalendarEntity.Day(value: 0)))
                continue
            }
            viewModels.append(DayViewModel(day: FilteringCalendarEntity.Day(value: day-month.firstWeekDay)))
            cellViewModels = viewModels
        }
        self.firstWeekDay = month.firstWeekDay
        self.lastWeekDay = month.lastWeekDay
        self.year = month.year
        self.month = month.month
    }
    
}

// MARK: - Providing Function

extension MonthViewModel {
    
    func getMonth() -> Int {
        return month
    }
    
    func getYear() -> Int {
        return year
    }
    
    func select(at index: Int, isFirst: Bool) {
        self.cellViewModels[index].select(isFirst: isFirst)
    }
    
    func getIsSelectable(at index: IndexPath) -> Bool {
        return self.cellViewModels[index.item].isSelectable
    }
    
    func getCellViewModel(at index: Int) -> DayViewModel {
        return cellViewModels[index]
    }
    
    func configure(with cellViewModels: [DayViewModel]) {
        self.cellViewModels = cellViewModels
    }
    
    func setBetween(firstDay: Int = 0, lastDay: Int? = nil) {
        guard let lastDay = lastDay else {
            for day in firstDay..<cellViewModels.count {
                cellViewModels[day].setBetWeen()
            }
            return
        }
        for day in firstDay...lastDay {
            cellViewModels[day].setBetWeen()
        }
        
    }
    
}
