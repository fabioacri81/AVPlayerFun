//
//  ViewControllerTests.swift
//  AVPlayerFunTests
//
//  Created by Fabio Acri on 04/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import XCTest
import AVFoundation
@testable import AVPlayerFun

class ViewControllerTests: XCTestCase {
    private var viewController: ViewController!

    override func setUp() {
        super.setUp()
        viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func test_WhenInit_ThenNotNil() {
        XCTAssertNotNil(viewController)
    }

    func test_WhenInit_ThenPresenterNotNil() {
        _ = viewController.view
        XCTAssertNotNil(viewController.presenter)
    }

    func test_WhenConfigurePlayer_ThenTableView() {
        _ = viewController.view
        viewController.viewDidLoad()
        XCTAssert(viewController.view.subviews.first is UITableView)

        let tableView = viewController.view.subviews.first as! UITableView
        XCTAssertEqual(tableView.backgroundColor, .black)
        XCTAssertEqual(tableView.separatorColor, .lightGray)
        XCTAssertEqual(tableView.estimatedRowHeight, 30.0)
        XCTAssert(tableView.delegate is ViewController)
        XCTAssert(tableView.dataSource is ViewController)
    }
}
