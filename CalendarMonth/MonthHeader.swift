//
//  MonthHeader.swift
//  Calendar
//
//  Created by Hudihka on 02/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class MonthHeader: UICollectionReusableView {
    
    @IBOutlet private var collectionLabels: UILabel!
	@IBOutlet private var separatorView: UIView!
    
    var month: Month? {
        didSet{
            collectionLabels.text = nil
            if let month = month {
                collectionLabels.text = month.nameMonth
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
		collectionLabels.textColor = ConstantCalendar.colorDay
		separatorView.backgroundColor = ConstantCalendar.colorDay
    }
    
}
