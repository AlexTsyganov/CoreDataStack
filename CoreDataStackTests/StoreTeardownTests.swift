//
//  StoreTeardownTests.swift
//  CoreDataStack
//
//  Created by Robert Edwards on 7/10/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import XCTest

class StoreTeardownTests: XCTestCase {

    var stack: CoreDataStack!

    override func setUp() {
        super.setUp()

        let bundle = NSBundle(forClass: CoreDataStackTests.self)
        let expectation = expectationWithDescription("callback")
        CoreDataStack.constructStack(withModelName: "TestModel", inBundle: bundle) { result in
            switch result {
            case .Success(let stack):
                self.stack = stack
            case .Failure(let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testPersistentStoreReset() {
        let expectation = expectationWithDescription("callback")
        stack.resetPersistentStoreCoordinator() { result in
            switch result {
            case .Success:
                break
            case .Failure(let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
