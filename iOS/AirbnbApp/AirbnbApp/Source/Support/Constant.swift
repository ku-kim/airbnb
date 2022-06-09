//
//  Constant.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/08.
//

import Foundation

// MARK: - String Extension

extension String {
    enum SFImage {
        static let mappinAndEllipse = "mappin.and.ellipse"
        static let magnifyingglass = "magnifyingglass"
        static let heart = "heart"
        static let person = "person"
        static let plusButton = "plus.circle"
        static let minusButton = "minus.circle"
    }
    
    enum MainTabBar {
        static let search = "검색"
        static let wishList = "위시리스트"
        static let reservation = "내 예약"
    }
    
    enum CustomSearchBar {
        static let placeholder = "어디로 여행가세요?"
    }
    
    enum SearchHome {
        enum SectionHeader {
            static let city = "가까운 여행지 둘러보기"
            static let theme = "어디에서나, 여행은 살아보는거야!"
        }
        
    }
    
    static let backButtonTitle = "뒤로"
    
    enum ViewControllerTitle {
        static let findPlace = "숙소 찾기"
    }
    
    enum FilteringCondition {
        static let location = "위치"
        static let checkInAndOut = "체크인/체크아웃"
        static let fee = "요금"
        static let headCount = "인원"
    }
    
    enum NextStep {
        static let leftButtonTitle = "건너뛰기"
        static let rightButtonTitle = "다음"
    }
    
    enum PriceRange {
        static let priceRangeLabel = "가격 범위"
        static let separaterLabel = "-"
    }
    
    enum DateFormat {
        static let calender = "yyyy.MM.dd.e"
    }
    
    enum YearViewModel {
        static let separater = " - "
    }
    
    enum Age {
        enum Title {
            static let adult = "성인"
            static let kid = "어린이"
            static let toddler = "유아"
        }
        
        enum Description {
            static let adult = "만 13세 이상"
            static let kid = "만 2~12세"
            static let toddler = "만 2세 미만"
        }
    }
    
    enum HeadCount {
        static let plus = "+"
        static let minus = "-"
    }
}

extension Array where Element == String {
    static let weekend = ["일", "월", "화", "수", "목", "금", "토"]
}

// MARK: - Int Extension

extension Int {
    enum HeadCount {
        static let maxGuestCount = 16
    }
}
