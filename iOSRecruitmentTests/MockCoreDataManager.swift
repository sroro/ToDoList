//
//  MockCoreDataManager.swift
//  iOSRecruitmentTests
//
//  Created by Rodolphe Schnetzer on 18/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import XCTest
@testable import iOSRecruitment

final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createTask(title: "My title", text: "My text")
        XCTAssertTrue(!coreDataManager.tasks.isEmpty)
        XCTAssertTrue(coreDataManager.tasks.count == 1)
        XCTAssertTrue(coreDataManager.tasks[0].text == "My text")
    }

    func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.createTask(title: "My title", text: "My text")
        coreDataManager.deleteAllTasks()
        XCTAssertTrue(coreDataManager.tasks.isEmpty)
    }
}

