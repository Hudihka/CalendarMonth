//
//  SupportCalendar.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit


struct Month {

    var days: [Date] = []
    var nameMonth: String
    var offset: Int = 0 //отступ для первого дня
    var isConteinsToday = false

    init(date: Date) {
        self.nameMonth = date.monthString
        
        self.offset = Date(date: date).nameDayMonth - 1
        self.days = date.daysArrayDate(date: date)
        
        if days.firstIndex(where: {$0.isTooDay}) != nil {
            isConteinsToday = true
        }
    }
    
    init(month: Int, year: Int) {
        
        let date = Date(day: 1, month: month, year: year)
        
        self.nameMonth = date.monthString
        
        self.offset = date.nameDayMonth - 1
        self.days = date.daysArrayDate(date: date)
        
        if days.firstIndex(where: {$0.isTooDay}) != nil {
            isConteinsToday = true
        }
    }
    

    func dateInIndex(index: IndexPath) -> Date? {
        let index = index.row - offset
        return days[safe: index]
    }

}


