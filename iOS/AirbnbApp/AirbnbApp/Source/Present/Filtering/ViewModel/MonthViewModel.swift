//
//  MonthViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

final class MonthViewModel {
    private var cellViewModels: [CalendarCellViewModel] = []
    
    private var lastWeekDay: Int = 0
    private var firstWeekDay: Int = 0
    var year: Int = 0
    var month: Int = 0
    
    let loadMonth = PublishRelay<Void>()
    
    init(month: FilteringCalendarEntity.Month) {
        loadMonth.bind { [ weak self ] in
            var viewModels: [CalendarCellViewModel] = []
            for day in 2...month.totalDay {
                if day < month.firstWeekDay {
                    viewModels.append(CalendarCellViewModel(day: FilteringCalendarEntity.Day(value: 0)))
                    continue
                }
                viewModels.append(CalendarCellViewModel(day: FilteringCalendarEntity.Day(value: day-month.firstWeekDay)))
                self?.cellViewModels = viewModels
            }
            self?.firstWeekDay = month.firstWeekDay
            self?.lastWeekDay = month.lastWeekDay
            self?.year = month.year
            self?.month = month.month
        }

    }
    var count: Int {
        return cellViewModels.count
    }
    
    func select(at index: Int) {
        self.cellViewModels[index].select()
    }
    
    func getCellViewModel(at index: Int) -> CalendarCellViewModel {
        return cellViewModels[index]
    }
    
    func configure(with cellViewModels: [CalendarCellViewModel]) {
        self.cellViewModels = cellViewModels
    }
}
