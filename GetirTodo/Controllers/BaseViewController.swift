//
//  BaseViewController.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 01/08/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    func setupUI() {
        DispatchQueue.main.async {
            self.setupNavigationBar()
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black;
        self.navigationController?.navigationBar.barTintColor = Utils().getCurrentThemeColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        UISearchBar.appearance().backgroundColor = Utils().getCurrentThemeColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
}
