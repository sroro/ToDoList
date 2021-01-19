//
//  CoreDataManager.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 17/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var tasks: [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "isArchived = %@", NSNumber(booleanLiteral: false)) // recuperera pas les task archivés
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    var tasksArchived: [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "isArchived = %@", NSNumber(booleanLiteral: true)) // recuperera les task archivés
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    
    

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func createTask(title: String, text:String, isArchived:Bool = false) {
        let task = Task(context: managedObjectContext)
        task.title = title
        task.text = text
        task.isArchived = isArchived
        coreDataStack.saveContext()
    }
    
    func updateTask(task:Task) {
        task.isArchived.toggle()
        coreDataStack.saveContext()
    }

    func deleteAllTasks() {
        tasks.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteAllTasksArchived() {
        tasksArchived.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    
    
    func deleteTask(task:Task) {
        managedObjectContext.delete(task)
        coreDataStack.saveContext()
    }
    
   
    
}
