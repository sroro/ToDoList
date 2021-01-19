//
//  CellTaskViewCell.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 17/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import UIKit

protocol CellInteraction {
    func didValideTask(task:Task)
}
class CellTaskViewCell: UITableViewCell {
    
    //MARK: - propertie
    
    var taskDetails : TaskDetails?
    var taskIsArchived : Bool?
    var cellInteractionDelegate : CellInteraction?
    
    var task: Task? {
        didSet{
            guard let task = task else { return}
            titleTaskLabel.text = task.title
            taskLabel.text = task.text
            if task.isArchived {
                isDoneTask.setImage(#imageLiteral(resourceName: "pouceFullFill"), for: .normal)
            }
        }
    }

    //MARK:- IBoutlet
    
    @IBOutlet weak var titleTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var isDoneTask: UIButton!
 
    
    //MARK: -IBActions
    
    
    @IBAction func isDoneTappedButton(_ sender: UIButton) {
        guard let task = task else { return }
        cellInteractionDelegate?.didValideTask(task: task)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
