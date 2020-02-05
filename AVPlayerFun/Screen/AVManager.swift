//
//  AVManager.swift
//  AVPlayerFun
//
//  Created by Fabio Acri on 01/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol AVManagerInterface: class {
    func preSetVideo(into controller: AVPlayerViewController, at index: Int)
    func playVideo()
    func hasItems() -> Bool
}

final class AVManager {
    private let player: AVPlayer
    private let allItems: [AVPlayerItem]
    
    init(player: AVPlayer, items: [AVPlayerItem]) {
        self.player = player
        self.allItems = items
    }
}

extension AVManager: AVManagerInterface {
    func preSetVideo(into controller: AVPlayerViewController, at index: Int) {
        guard !allItems.isEmpty else {
            return
        }
        
        controller.player = player
        let newItem = allItems[index]
        player.replaceCurrentItem(with: newItem)
    }

    func playVideo() {
        player.play()
    }

    func hasItems() -> Bool {
        return !allItems.isEmpty
    }
}
