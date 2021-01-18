//
//  CellTaskViewCell.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 17/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import UIKit

class CellTaskViewCell: UITableViewCell {
    
    @IBOutlet weak var titleTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var deleteTaskButton: UIButton!
    @IBOutlet weak var validateTask: UIButton!
    
    
    @IBAction func validateTaskButton(_ sender: Any) {
        validateTask.isSelected.toggle()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    
    var task: Task? {
        didSet{
            titleTaskLabel.text = task?.title
            taskLabel.text = task?.text
        }
    }
}
