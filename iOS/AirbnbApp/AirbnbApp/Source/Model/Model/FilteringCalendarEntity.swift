//
//  FilteringCalendarEntity.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/04.
//

import Foundation

struct FilteringCalendarEntity {
    struct Date {
        let month: Int
        let day: Int
    }
    
    struct Month {
        var year: Int {
            return firstWeekDate[0]
        }
        var month: Int {
            return firstWeekDate[1]
        }
        var firstWeekDay: Int {
            return firstWeekDate[3]
        }
        var lastWeekDay: Int {
            return lastWeekDate[3]
        }
        var totalDay: Int {
            return lastWeekDate[2] + firstWeekDay
        }
        var count: Int {
            return days.count
        }
        var days: [Day] {
            var array: [Day] = []
            (1...totalDay).forEach { day in
                array.append(Day(value: day))
            }
            return array
        }
        private let firstWeekDate: [Int]
        private let lastWeekDate: [Int]
        
        init(_ firstWeekDate: [Int], _ lastWeekDate: [Int]) {
            self.firstWeekDate = firstWeekDate
            self.lastWeekDate = lastWeekDate
        }
    }
    
    struct Day {
        let value: Int
    }
}
