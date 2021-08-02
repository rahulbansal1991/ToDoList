//
//  StringExtension.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation
import UIKit

extension String {
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
