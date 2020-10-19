//
//  UIView.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }


        func addRadius(number: CGFloat) {
            self.layer.cornerRadius = number
            self.layer.masksToBounds = true
        }
    
        func cirkleView() {
            let radius = self.frame.height / 2
            self.addRadius(number: radius)
        }
}


