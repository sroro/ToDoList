//
//  TasksViewController.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 16/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView! { didSet{ taskTableView.tableFooterView = UIView()} }
    @IBOutlet weak var addTaskButton: UIButton!
    
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        // utilsier la cellule personnalisé .xib
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "CellTaskViewCell")
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }
    
    @IBAction func deleteTasksBarButton(_ sender: UIBarButtonItem) {
        alertDeleteAllTasks()
        coreDataManager?.deleteAllTasks()
        taskTableView.reloadData()
    }
    
 
    
}
