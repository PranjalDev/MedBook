//
//  UITextField+Extension.swift
//  MedBook
//
//  Created by Pranjal Verma on 23/10/23.
//

import UIKit

extension UITextField {
    func addBottomLine(color: UIColor = .black) {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = color.cgColor
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width, height: 2)
        self.layer.addSublayer(bottomLine)
    }
}
