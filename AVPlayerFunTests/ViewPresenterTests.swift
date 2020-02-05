//
//  ViewPresenterTests.swift
//  AVPlayerFunTests
//
//  Created by Fabio Acri on 04/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import XCTest
import AVFoundation
@testable import AVPlayerFun

class ViewPresenterTests: XCTestCase {
    private var presenter: ViewPresenter!
    private var mockedView: MockView!

    override func setUp() {
        super.setUp()
        mockedView = MockView()
        presenter = ViewPresenter(view: mockedView)
    }

    override func tearDown() {
        presenter = nil
        mockedView = nil
        super.tearDown()
    }

    func test_WhenNumberOfSections_ThenEqualToOne() {
        presenter.onViewDidLoad()
        XCTAssertEqual(presenter.numberOfSections(), 1)
    }

    func test_WhenNumberOfRows_ThenEqualToThree() {
        presenter.onViewDidLoad()
        XCTAssertEqual(presenter.numberOfRows(), 3)
    }

    func test_WhenCellTextAtId0_ThenEqualToTitleId0() {
        presenter.onViewDidLoad()
        XCTAssertEqual(presenter.cellText(at: 0), "Japan")
    }

    func test_WhenCellTextAtId0_ThenEqualToTitleId1() {
        presenter.onViewDidLoad()
        XCTAssertEqual(presenter.cellText(at: 1), "Niagara")
    }

    func test_WhenCellTextAtId0_ThenEqualToTitleId2() {
        presenter.onViewDidLoad()
        XCTAssertEqual(presenter.cellText(at: 2), "Pozzuoli")
    }

    func test_WhenOnViewDidLoad_ThenConfigureAVManager() {
        presenter.onViewDidLoad()
        XCTAssertNotNil(mockedView.spyConfigureAVManager)
    }
    
    func test_WhenOnViewDidLoad_ThenConfigureTableView() {
        presenter.onViewDidLoad()
        XCTAssertEqual(mockedView.spyConfigureTableViewCount, 1)
    }

    func test_GivenDataBuilderEmptyData_WhenOnViewDidLoad_ThenViewOnFailed() {
        let mockedBuilder = MockDataBuilder()
        mockedBuilder.stubbedData = []
        presenter = ViewPresenter(view: mockedView, dataBuilder: mockedBuilder)

        presenter.onViewDidLoad()

        XCTAssertEqual(mockedView.spyOnFailedCount, 1)
    }

    func test_GivenDataBuilderEmptyData_WhenOnViewDidLoad_ThenViewDoesNotFail() {
        let mockedBuilder = MockDataBuilder()
        mockedBuilder.stubbedData = [PlayerItemModel(title: "someTitle", avPlayerItem: AVPlayerItem(url: URL(string: "somepath")!))]
        presenter = ViewPresenter(view: mockedView, dataBuilder: mockedBuilder)

        presenter.onViewDidLoad()

        XCTAssertEqual(mockedView.spyOnFailedCount, 0)
    }
}

private class MockView: ViewControllerInterface {
    private(set) var spyConfigureAVManager = [AVManagerInterface]()
    private(set) var spyConfigureTableViewCount = 0
    private(set) var spyOnFailedCount = 0

    func configureAVManager(with manager: AVManagerInterface) {
        spyConfigureAVManager.append(manager)
    }
    
    func configureTableView() {
        spyConfigureTableViewCount += 1
    }

    func onFailed() {
        spyOnFailedCount += 1
    }
}

private class MockDataBuilder: DataBuilderInterface {
    var stubbedData = [PlayerItemModel]()

    func prepareData() -> [PlayerItemModel] {
        return stubbedData
    }
}
