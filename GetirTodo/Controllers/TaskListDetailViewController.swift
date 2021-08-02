//
//  TaskListDetailViewController.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import UIKit

class TaskListDetailViewController: BaseViewController {

    var task : Task?
    
    var viewModel : TaskListDetailViewModel!
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvDetail: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    class func instantiateViewController() -> TaskListDetailViewController {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskListDetailViewController") as! TaskListDetailViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TaskListDetailViewModel()
        
        loadData()
    }
    
    override func setupUI() {
        
        super.setupUI()
        
        addBorderAndRoundCorner(view: tfTitle)
        addBorderAndRoundCorner(view: tvDetail)
        
        self.navigationItem.title = "Task Detail"
    }
    
    func addBorderAndRoundCorner(view : UIView) {
        view.addBorderOf(color: .lightGray, width: 0.5)
        view.addRoundedCorner()
    }
    
    func loadData() {
        
        guard let actualTask = task else {
            return
        }
        
        // Auto populate the data in case of update
        
        tfTitle.text = actualTask.title
        tvDetail.text = actualTask.detail
        
        btnSave.setTitle("Update", for: UIControl.State.normal)
    }
    
    @IBAction func didTapOnSaveButton(_ sender: UIButton) {
        
        if !checkValidation() {
            return
        }
        
        // Update the task details in case of Update
        if let actualTask = task {
            
            viewModel.updateTask(task: actualTask, title: tfTitle.text!, detail: tvDetail.text) { (status) in
                
                if status {
                    // Show Success Alert
                    Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.success.rawValue, message: AlertMessage.Message.taskUpdated.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                        
                        // Pop to previous screen
                        self.navigationController?.popViewController(animated: true)
                  }))
                    
                } else {
                    // Show Fail Alert
                    Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.fail.rawValue, message: AlertMessage.Message.error.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: nil))
                }
            }
            
        } else {
            
            viewModel.saveTask(title: tfTitle.text!, detail: tvDetail.text) { (status) in
                
                if status {
                    // Show Success Alert
                    Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.success.rawValue, message: AlertMessage.Message.taskSaved.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                        
                        // Pop to previous screen
                        self.navigationController?.popViewController(animated: true)
                  }))
                    
                } else {
                    // Show Fail Alert
                    Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.fail.rawValue, message: AlertMessage.Message.error.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: nil))
                }
            }
        }
    }
    
    @IBAction func didTapOnDeleteButton(_ sender: UIButton) {
        
        guard let actualTask = task else {
            
            // Show Fail Alert
            Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.fail.rawValue, message: AlertMessage.Message.error.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: nil))
            
            return
        }
        
        // Prompt before deleting the task
        Utils.showAlterWithListenerBack(controller: self,
                                        title: AlertMessage.Title.alert.rawValue,
                                        message: AlertMessage.Message.confirmation.rawValue,
                                        listener: UIAlertAction.init(title: "Yes", style: .default, handler: { (action) in
                                            self.deleteTask(task: actualTask)
                                        }),
                                        listener2: UIAlertAction.init(title: "No", style: .default, handler: nil))
    }
    
    func deleteTask(task : Task) {
        
        viewModel.deleteTask(task: task) { (status) in
            
            if status {
                // Show Success Alert
                Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.success.rawValue, message: AlertMessage.Message.taskDelete.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                    
                    // Pop to previous screen
                    self.navigationController?.popViewController(animated: true)
              }))

            } else {
                // Show Fail Alert
                Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.fail.rawValue, message: AlertMessage.Message.error.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: nil))
            }
        }
    }
    
    func checkValidation() -> Bool {
        
        if tfTitle.text?.count == 0 || tfTitle.text?.removingWhitespaces().count == 0 {
            
            tfTitle.addBorderOf(color: .red, width: 1)
            
            return false
        }
        
        if tvDetail.text?.count == 0 || tvDetail.text?.removingWhitespaces().count == 0 {
            
            tvDetail.addBorderOf(color: .red, width: 1)
            
            return false
        }
        
        // Validation passed
        tfTitle.addBorderOf(color: .lightGray, width: 0.5)
        tvDetail.addBorderOf(color: .lightGray, width: 0.5)
        
        return true
    }
}
