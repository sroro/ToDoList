//
//  ArchivesViewController.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 16/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import UIKit
class ArchivesViewController: UIViewController {
    
    @IBOutlet weak var archivesTableView: UITableView!
    private var coreDataManager: CoreDataManager?
    
    @IBAction func deleteArchivesButton(_ sender: UIBarButtonItem) {
        alertTwoChoiceDeleteTask(title: "Delete All Task?", message: "sure sure? ?") { (success) in
            guard success == true else {return}
            self.coreDataManager?.deleteAllTasksArchived()
            self.archivesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        // utilsier la cellule personnalisé .xib
        super.viewDidLoad()
        archivesTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "CellTaskViewCell")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }
    // permet de recharger la tableview une fois une new tach ajouter
    override func viewWillAppear(_ animated: Bool) {
        archivesTableView.reloadData()
    }
}

//MARK:- extension TableViewDataSource

extension ArchivesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager?.tasksArchived.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = archivesTableView.dequeueReusableCell(withIdentifier: "CellTaskViewCell", for: indexPath) as? CellTaskViewCell else { return UITableViewCell() }
        cell.task = coreDataManager?.tasksArchived[indexPath.row]
        return cell
    }
}

//MARK:- extension TableViewDelegate

extension ArchivesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    /// delete cell by swip left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let coreDataManager = coreDataManager else { return }
            coreDataManager.deleteTask(task: coreDataManager.tasksArchived[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

