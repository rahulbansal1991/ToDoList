//
//  TaskListViewController.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import UIKit

class TaskListViewController: BaseViewController {

    let viewModel = TaskListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Tasks"
        
        loadData()
    }
    
    override func setupUI() {
        
        super.setupUI()
        
        tableView.removeEmptyCells()
    }
    
    func setupBindings() {
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellReuseIdentifierTaskList)
                
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func loadData() {
        
        viewModel.fetchTasks()
        
        tableView.reloadData()
    }
    
    func showNoDataView() {
        
        let lblNoData = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        lblNoData.text = "No tasks found"
        lblNoData.textAlignment = .center
        lblNoData.font = UIFont.systemFont(ofSize: 14)
        lblNoData.textColor = UIColor.lightGray
        lblNoData.center = self.view.center
        tableView.backgroundView = lblNoData
    }
    
    func hideNoDataView() {
        tableView.backgroundView = nil
    }
    
    func gotoTaskDetailScreen(task : Task) {
        
        let taskDetailVC = TaskListDetailViewController.instantiateViewController()
        taskDetailVC.task = task
        self.navigationController?.pushViewController(taskDetailVC, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.taskList.count == 0 ? showNoDataView() : hideNoDataView()
        
        return viewModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdentifierTaskList, for: indexPath)
        
        let currentItem = viewModel.taskList[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.textLabel?.text = currentItem.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentItem = viewModel.taskList[indexPath.row]
        
        gotoTaskDetailScreen(task: currentItem)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            // Fetch clicked task
            let task = viewModel.taskList[indexPath.row]
            
            viewModel.deleteTask(task: task) { (status) in
                
                if status {
                    // Show Success Alert
                    Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.success.rawValue, message: AlertMessage.Message.taskDelete.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                        
                        // Refresh the task list
                        self.loadData()
                    }))

                } else {
                    // Show Fail Alert
                    Utils.showAlterWithListenerBack(controller: self, title: AlertMessage.Title.fail.rawValue, message: AlertMessage.Message.error.rawValue, listener: UIAlertAction.init(title: "OK", style: .default, handler: nil))
                }
            }
        }
    }
}
