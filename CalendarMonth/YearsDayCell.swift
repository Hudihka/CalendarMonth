//
//  YearsDayCell.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class YearsDayCell: UICollectionViewCell {


    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var constreintWidthCell: NSLayoutConstraint!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!

    var parser: DateParser? {
        didSet{
            desingView()
        }
    }
    
    var day: Date? {
        didSet{
            desingView()
        }
    }

    private func desingView(){

        clearView()

        guard let day = day else {
            return
        }

        //габариты лейбла
		
		let width = self.contentView.frame.size.width

		let sizeLabel = 0.8 * width
        constreintWidthCell.constant = 0.8 * width

        labelDay.addRadius(number: sizeLabel * 0.5)
        labelDay.layer.borderWidth = 2


        labelDay.text = day.dayNumber
        if let parser = parser {
            labelDay.alpha = parser.dateInDiapason(date: day) ? 1 : 0.3
        }

		labelDay.textColor = day.isWeekend ? ConstantCalendar.colorWekend : ConstantCalendar.colorDay
        
        //ширифт

        labelDay.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        //округлениие вью

        if day.isTooDay {
			labelDay.layer.borderColor = ConstantCalendar.colorDay.cgColor
        }

        selected(date: day)
    }

    private func selected(date: Date){
        
        guard let parser = parser else {
            return
        }
        

        if let oneSelected = parser.selectedDataOne, oneSelected == date{
            settingsLabelSelected(from: true)
            return
        }

        if let twoSelected = parser.selectedDataTwo, twoSelected == date {
            settingsLabelSelected(from: false)
            return
        }

        if parser.dateInDiapasonSelected(date: date){
            rightView.backgroundColor = ConstantCalendar.selectedView
            leftView.backgroundColor = ConstantCalendar.selectedView
        }

    }

    private func settingsLabelSelected(from: Bool){
		labelDay.textColor = ConstantCalendar.colorTextSelected
        labelDay.backgroundColor = ConstantCalendar.colorWekend

        guard let parser = parser,
              let dataOne = parser.selectedDataTwo,
              let dataTwo = parser.selectedDataOne,
              dataOne != dataTwo else {
            return
        }

        if from {
            rightView.backgroundColor = ConstantCalendar.selectedView
        } else {
            leftView.backgroundColor = ConstantCalendar.selectedView
        }

    }

    private func clearView(){

        labelDay.text = ""
        labelDay.layer.borderColor = UIColor.clear.cgColor


        labelDay.backgroundColor = UIColor.clear
        labelDay.textColor = ConstantCalendar.colorDay

        leftView.backgroundColor = UIColor.clear
        rightView.backgroundColor = UIColor.clear
    }

}
