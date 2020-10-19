//
//  CollectionCalendar.swift
//  Calendar
//
//  Created by Hudihka on 18/10/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

//выкладывал по этому уроку
//https://medium.com/flawless-app-stories/create-your-own-cocoapods-library-da589d5cd270

public class CollectionCalendar: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate{
	
	var blockTextHeader : (String) -> () = { _ in }
	private var oldTextYear: String? = nil
	
	private var month: [Month] = []
	
	var dataParser = DateParser(){
		didSet{
			self.month = dataParser.arrayMonth
			self.reloadData()
		}
	}
	
	

	
	init(frame: CGRect, dataParser: DateParser) {
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		let offsetCollection = 2 * ConstantCalendar.offsetCV
		let offsetCells = 6 * ConstantCalendar.offsetCell
		
		let widt = (frame.width - offsetCollection - offsetCells)/7
		layout.estimatedItemSize = CGSize(width: widt, height: widt)
		layout.minimumInteritemSpacing = ConstantCalendar.offsetCell
		
		layout.headerReferenceSize = CGSize(width: frame.size.width, height: ConstantCalendar.headerHeight)
		
		super.init(frame: frame, collectionViewLayout: layout)

		self.dataParser = dataParser
		self.month = dataParser.arrayMonth
		
		self.delegate = self
		self.dataSource = self
		self.backgroundColor = UIColor.clear
		
		self.registerCell(cellName: "YearsDayCell")
		self.registerHeader(headerName: "MonthHeader")
		
		self.contentInset = UIEdgeInsets(top: 0, left: ConstantCalendar.offsetCV, bottom: 0, right: ConstantCalendar.offsetCV)
		
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
//		let frame = aDecoder.frame
		
		let offsetCollection = 2 * ConstantCalendar.offsetCV
		let offsetCells = 6 * ConstantCalendar.offsetCell
		
		let widt = (frame.width - offsetCollection - offsetCells)/7
		layout.estimatedItemSize = CGSize(width: widt, height: widt)
		layout.minimumInteritemSpacing = ConstantCalendar.offsetCell
		
		layout.headerReferenceSize = CGSize(width: frame.size.width, height: ConstantCalendar.headerHeight)
		
		self.collectionViewLayout = layout
		
		self.delegate = self
		self.dataSource = self
		self.backgroundColor = UIColor.clear
		
		//		translatesAutoresizingMaskIntoConstraints = false
		
		self.registerCell(cellName: "YearsDayCell")
		self.registerHeader(headerName: "MonthHeader")
		
		self.contentInset = UIEdgeInsets(top: 0, left: ConstantCalendar.offsetCV, bottom: 0, right: ConstantCalendar.offsetCV)
		
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
	}
	
	
	func scrollCollection(){
		
		if ConstantCalendar.scrollInTooDay == false {
			return
		}
		
		if let section = self.month.firstIndex(where: {$0.isConteinsToday}), section != 0 {
			//скроллим к хедеру
			
			if let attributes = self.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader,
																			 at: IndexPath(item: 0, section: section)) {
				var offsetY = attributes.frame.origin.y - self.contentInset.top
				offsetY -= self.safeAreaInsets.top
				self.setContentOffset(CGPoint(x: 0, y: offsetY), animated: ConstantCalendar.aniateScroll)
			}
			
			
			textHeder()
		}
		
	}
	
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return month.count
	}
	
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let mon = month[section]
		return mon.days.count + mon.offset
	}
	
	//MARK: - Cells
	
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearsDayCell", for: indexPath) as! YearsDayCell
		
		let ind = indexPath.row
		let mon = month[indexPath.section]
		let offset = mon.offset
		
		if offset != 0, ind < offset { //пустая ячейка
			cell.day = nil
			return cell
		}
		
		cell.day = mon.days[ind - offset]
		
		return cell
	}
	
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if ConstantCalendar.enableDay == false {
			return
		}
		
		guard ConstantCalendar.enableDay,
			let date = month[indexPath.section].dateInIndex(index: indexPath),
			dataParser.dateInDiapason(date: date) else {return}
		
		dataParser.selectedDate(date: date)
		self.reloadData()
	}
	
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let collectionViewCell = cell as? YearsDayCell else {
			return
		}
		
		collectionViewCell.parser = self.dataParser
	}
	

	
	//MARK: - Header
	
    public func collectionView(_ collectionView: UICollectionView,
						viewForSupplementaryElementOfKind kind: String,
						at indexPath: IndexPath) -> UICollectionReusableView {
		
		let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MonthHeader", for: indexPath) as! MonthHeader
		view.month = month[indexPath.section]
		return view
		
	}
	
	//MARK: - SCROLL
	
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		textHeder()
	}
	
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
								   withVelocity velocity: CGPoint,
								   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		textHeder()
		
	}
	
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
								  willDecelerate decelerate: Bool){
		textHeder()
	}
	
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
		textHeder()
	}
	
	
	fileprivate func textHeder(){
		if let cell = self.visibleCells.first as? YearsDayCell, let text = cell.day?.year {
			let textYear = "\(text)"
			if oldTextYear != textYear {
				oldTextYear = textYear
				blockTextHeader(textYear)
			}
		}
	}
	
}
