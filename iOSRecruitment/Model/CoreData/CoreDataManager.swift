//
//  CoreDataManager.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 17/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var tasks: [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func createTask(title: String, text:String) {
        let task = Task(context: managedObjectContext)
        task.title = title
        task.text = text
        coreDataStack.saveContext()
    }

    func deleteAllTasks() {
        tasks.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
