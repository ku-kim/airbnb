//
//  YearViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

final class YearViewModel {
    
    let loadCalendar = PublishRelay<Void>()
    let loadedCalendar = PublishRelay<YearViewModel>()
    let updatedRange = PublishRelay<[(MonthViewModel, DayViewModel)]>()
    
    private var monthViewModels: [MonthViewModel] = []
    private var selectedRange: [IndexPath] = []
    
    var count: Int {
        return monthViewModels.count
    }
    
    init() {
        bind()
    }
}

private extension YearViewModel {
    
    func toggleRange() {
        selectedRange.enumerated().forEach {
            monthViewModels[$0.element.section].select(at: $0.element.item, isFirst: $0.offset == 0)
        }
        setBetween()
        
    }
    
    func setBetween() {
        guard let firstDate = selectedRange.first else { return }
        guard let lastDate = selectedRange.last else { return }
        
        for month in firstDate.section...lastDate.section {
            let targetMonth = monthViewModels[month]
            
            if month == firstDate.section && month != lastDate.section {
                targetMonth.setBetween(firstDay: firstDate.item)
                continue
            }
            
            if month != firstDate.section && month != lastDate.section {
                targetMonth.setBetween()
                continue
            }
            
            if month != firstDate.section && month == lastDate.section {
                targetMonth.setBetween(lastDay: lastDate.item)
                continue
            }
            
            targetMonth.setBetween(firstDay: firstDate.item, lastDay: lastDate.item)
        }
    }
    
    func bind() {
        loadCalendar.bind { [ weak self ] in
            guard let calendar = self?.makeCalendar() else { return }
            let months = calendar.map {
                MonthViewModel(month: $0)
            }
            
            self?.monthViewModels = months
            guard let self = self else { return }
            self.loadedCalendar.accept(self)
        }
    }
    
    func makeCalendar() -> [FilteringCalendarEntity.Month] {
        let format = String.DateFormat.calender
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

// MARK: - Providing Function

extension YearViewModel {
    
    func selectDay(at indexPath: IndexPath) {
        if !monthViewModels[indexPath.section].getIsSelectable(at: indexPath) {
            return
        }
        toggleRange()
        
        if selectedRange.isEmpty || selectedRange[0] > indexPath {
            selectedRange = [indexPath]
        } else if selectedRange[0] == indexPath {
            selectedRange = []
        } else {
            selectedRange = [selectedRange[0], indexPath]
        }
        
        toggleRange()
        //        var checkInRange: [String] = []
        guard let checkInDate = selectedRange.first else { return }
        guard let checkOutDate = selectedRange.last else { return }
        let monthViewModel1 = monthViewModels[checkInDate.section]
        let dayViewModel1 = monthViewModel1.getCellViewModel(at: checkInDate.item)
        let monthViewModel2 = monthViewModels[checkOutDate.section]
        let dayViewModel2 = monthViewModel2.getCellViewModel(at: checkOutDate.item)
        
        let dateRange = [(monthViewModel1, dayViewModel1), (monthViewModel2, dayViewModel2)]
        //        selectedRange.enumerated().forEach {
        //          let date = $0.element
        //          let monthViewModel = monthViewModels[date.section]
        //          let dayViewModel = monthViewModel.getCellViewModel(at: date.item)
        //          checkInRange.append("\(monthViewModel.getMonth())월 \(dayViewModel.getDay())일")
        //        }
        
        updatedRange.accept(dateRange)
        //        loadedRange.accept(checkInRange.joined(separator: .YearViewModel.separater))
    }
    
    func getMonthViewModel(at index: Int) -> MonthViewModel {
        return monthViewModels[index]
    }
    
}
