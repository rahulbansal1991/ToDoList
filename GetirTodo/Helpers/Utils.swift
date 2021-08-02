//
//  Utils.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import UIKit

class Utils: NSObject {
    
    class func showAlterWithListenerBack(controller: UIViewController, title: String, message: String, listener: UIAlertAction, listener2 : UIAlertAction? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let button1 = listener
        
        let button2 = listener2
        
        alertController.addAction(button1)
        
        if let nButton2 = button2 {
            alertController.addAction(nButton2)
        }
        
        // Present Dialog message
        controller.present(alertController, animated: true, completion:nil)
    }
    
    func getCurrentThemeColor() -> UIColor {
        return UIColor.systemBlue
    }
}
