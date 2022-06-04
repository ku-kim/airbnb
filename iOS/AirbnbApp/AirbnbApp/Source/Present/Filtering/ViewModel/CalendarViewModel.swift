//
//  CalendarViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

final class CalendarViewModel {
    private var monthViewModels: [MonthViewModel] = []
    
    let loadCalendar = PublishRelay<Void>()
    let loadedCalendar = PublishRelay<CalendarViewModel>()

    private var selectedRange: [IndexPath] = []
    
    var count: Int {
        return monthViewModels.count
    }
    
    func toggleRange() {
        selectedRange.forEach {
            monthViewModels[$0.section].select(at: $0.item)
        }
    }
    
    func selectDay(at indexPath: IndexPath) {
        toggleRange()

        if selectedRange.isEmpty || selectedRange[0] > indexPath {
            selectedRange = [indexPath]
        } else if selectedRange[0] == indexPath {
            selectedRange.removeAll()
        } else {
            selectedRange = [selectedRange[0], indexPath]
        }

        toggleRange()
    }
    
    func getMonthViewModel(at index: Int) -> MonthViewModel {
        return monthViewModels[index]
    }
    
    init() {
        bind()
    }
}

private extension CalendarViewModel {
    
    func bind() {
        loadCalendar.bind { [ weak self ] in
            guard let calendar = self?.makeCalendar() else { return }
            let months = calendar.map {
                MonthViewModel(month: $0)
            }
            months.forEach {
                $0.loadMonth.accept(())
            }
            self?.monthViewModels = months
            guard let self = self else { return }
            self.loadedCalendar.accept(self)
        }
    }
    
    func makeCalendar() -> [FilteringCalendarEntity.Month] {
        let format = "yyyy.MM.dd.e"
        var date = Date()
        
        var startDate: Date {
            return date.startOfMonth()
        }
        
        var endDate: Date {
            return date.endOfMonth()
        }
          
        var startDateArray: [Int] {
            return startDate.toString(format: format).components(separatedBy: ".").map { Int($0) ?? 0}
        }
        
        var lastDateArray: [Int] {
            return startDate.endOfMonth().toString(format: format).components(separatedBy: ".").map { Int($0) ?? 0}
        }
        
        var calendarArray: [FilteringCalendarEntity.Month] = []
        
        for _ in 0..<12 {
            calendarArray.append(FilteringCalendarEntity.Month(startDateArray, lastDateArray))
            guard let nextFirstDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate) else { return []}
            date = nextFirstDate
        }
        return calendarArray
    }
}
