//
//  DateParser.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class DateParser {

    var dateFrom: Date? = Date(day: 1, month: 2, year: 2019)
    var dateTo: Date? = Date(day: 10, month: 6, year: 2023)

//    /*
//     если селектДата1 есть значение а селектДата2 нет
//     то дата 1 является конечной
//
//     если есть оба эти значения и пользаватель нажимает еще раз
//     эти оба значения сбрасываютя
//
//     */

    var selectedDataOne: Date? = nil
    var selectedDataTwo: Date? = nil


    private let countSeconds: Double = 3600 * 24 * 60
    
    //если мы не задаем начальную и конечную дату
    //то она задается в расчете от текушей даты
    //+- 3600 * 24 * 60 секунд
    //
    
    private var customFrom: Date {
        return dateFrom ?? Date(timeInterval: -1 * (countSeconds), since: Date())
    }
    
    private var customTo: Date {
        return dateTo ?? Date(timeInterval: countSeconds, since: Date())
    }

    func dateInDiapason(date: Date?) -> Bool {
        guard let date = date else {
            return false
        }

        if customFrom <= date, date <= customTo {
            return true
        }

        return false
    }


    
    var arrayMonth: [Month] {

        if customFrom > customTo {
            return []
        }
        
        let fromEar = customFrom.year
        let toEar = customTo.year
        
        let fromMonth = customFrom.month
        let toMonth = customTo.month
        
        var month: [Month] = []
        
        if fromEar == toEar {
            
            for mon in fromMonth...toMonth{
                month.append(Month(month: mon, year: fromEar))
            }
            
            return month
            
        } else {
            
            let arrayYear = [Int](fromEar...toEar)
            
            for year in arrayYear {
                
                if year == fromEar { //перебираем первый месяц
                    for mon in fromMonth...12{
                        month.append(Month(month: mon, year: year))
                    }
                } else if year == toEar { //перебираем последний месяц
                    for mon in 1...toMonth{
                        month.append(Month(month: mon, year: year))
                    }
                } else {
                    for mon in 1...12{
                        month.append(Month(month: mon, year: year))
                    }
                }
            }
            
            return month
            
        }
        
    }

    //MARK: - SELECTED


    func dateInDiapasonSelected(date: Date) -> Bool {
        guard let selectedDataOne = selectedDataOne,
            let selectedDataTwo = selectedDataTwo else {
                return false
        }


        if selectedDataOne < date, date < selectedDataTwo {
            return true
        }

        return false
    }
    


    func selectedDate(date: Date){

        if selectedDataOne == nil, selectedDataTwo == nil {
            selectedDataOne = date
        } else if let selectOne = selectedDataOne, selectedDataTwo == nil {

            if selectOne <= date {
                selectedDataTwo = date
            } else {
                selectedDataTwo = selectOne
                selectedDataOne = date
            }


        } else if selectedDataOne != nil, selectedDataTwo != nil {
            selectedDataOne = nil
            selectedDataTwo = nil
        }
    }
    
}
