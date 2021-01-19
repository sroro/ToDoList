//
//  TasksViewController.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 16/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    //MARK: - Properties
    var coreDataManager: CoreDataManager?
    var taskSelected : Task?
    
    // MARK: - IbOutlets & IBActions
    @IBOutlet weak var taskTableView: UITableView! { didSet{ taskTableView.tableFooterView = UIView()} }
    @IBAction func addTaskButton(_ sender: Any) {
        //        self.performSegue(withIdentifier: "segueToTask", sender: nil)
    }
    ///delete all tasks
    @IBAction func deleteTasksBarButton(_ sender: UIBarButtonItem) {
        alertTwoChoiceDeleteTask(title: "Delete All Task?", message: "sure sure? ?") { (success) in
            guard success == true else {return}
            self.coreDataManager?.deleteAllTasks()
            self.taskTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        /// use cellule .xib
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "CellTaskViewCell")
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTableView.reloadData()
    }
    
}

// MARK: - extension TableViewDataSource

extension TasksViewController:  UITableViewDataSource {
    
    /// Number of elements in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager?.tasks.count ?? 0
    }
    
    /// Create and define  tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTaskViewCell", for: indexPath) as? CellTaskViewCell else { return UITableViewCell() }
        cell.task = coreDataManager?.tasks[indexPath.row]
        cell.cellInteractionDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskSelected = coreDataManager?.tasks[indexPath.row] // stock task selected by cell
        performSegue(withIdentifier: "segueToTask", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let taskSelected = taskSelected else { return }
        guard let titleSelected = taskSelected.title else { return }
        guard let textSelected = taskSelected.text else { return }
        if segue.identifier == "segueToTask" {
            let vcDestination = segue.destination as? CreateTaskViewController
            let taskDetails = TaskDetails(title: titleSelected, text: textSelected
            )
            vcDestination?.taskDetails = taskDetails
            
        }
    }
}

//MARK:- extension TableViewDelegate

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let coreDataManager = coreDataManager else { return }
            coreDataManager.deleteTask(task: coreDataManager.tasks[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK:- extension protocole

extension TasksViewController : CellInteraction {
    func didValideTask(task: Task) {
        coreDataManager?.updateTask(task: task)
        taskTableView.reloadData()
    }
    
    
    
}
