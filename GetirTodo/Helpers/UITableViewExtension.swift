//
//  UITableViewExtension.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation
import UIKit

extension UITableView {
    
    func removeEmptyCells() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 1))
    }
}
