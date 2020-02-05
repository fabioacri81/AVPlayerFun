//
//  AVManagerTests.swift
//  AVPlayerFunTests
//
//  Created by Fabio Acri on 04/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import XCTest
import AVKit
import AVFoundation
@testable import AVPlayerFun

class AVManagerTests: XCTestCase {
    private var manager: AVManager!
    
    func test_WhenInitWithEmptyData_ThenHasItemsFalse() {
        manager = AVManager(player: AVPlayer(), items: [])
        XCTAssertFalse(manager.hasItems())
    }
    
    func test_WhenInitWithData_ThenHasItemsTrue() {
        let stubbedItem = AVPlayerItem(url: URL(string: "somePathHere")!)
        manager = AVManager(player: AVPlayer(), items: [stubbedItem])
        
        XCTAssertTrue(manager.hasItems())
    }
    
    func test_WhenInitWithItem_AndPresetVideo_ThenControllerPlayerItemMatches() {
        let stubbedItem = AVPlayerItem(url: URL(string: "somePathHere")!)
        manager = AVManager(player: AVPlayer(), items: [stubbedItem])
        
        let avPlayerController = AVPlayerViewController()
        manager.preSetVideo(into: avPlayerController, at: 0)
        
        XCTAssertEqual(avPlayerController.player?.currentItem, stubbedItem)
    }
}
