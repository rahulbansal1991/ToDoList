//
//  UIViewExtension.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorderOf(color: UIColor, width: CGFloat) -> Void {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func addRoundedCorner() -> Void {
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
}
