//
//  ViewController.swift
//  CalendarMonthExample
//
//  Created by Админ on 19.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collection: CollectionCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dataParser = DateParser()
        dataParser.dateFrom = Date(day: 1, month: 1, year: 2019)
        dataParser.dateTo = Date(day: 31, month: 12, year: 2021)
        
        collection.dataParser = dataParser
        collection.blockTextHeader = {[weak self] text in
            self?.title = text
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collection.scrollCollection()
    }


}

