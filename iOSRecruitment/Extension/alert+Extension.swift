//
//  alert+Extension.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 17/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import UIKit

extension UIViewController {
 
    
    ///multi choices alert delete All tasks
    
    func alertTwoChoiceDeleteTask(title: String, message: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            completion(false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func alertAddText() {
        let alert = UIAlertController(title: "Warning", message: "Add some text", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
