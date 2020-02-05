//
//  ViewPresenter.swift
//  AVPlayerFun
//
//  Created by Fabio Acri on 03/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import AVFoundation

protocol ViewPresenterInterface: class {
    func onViewDidLoad()
    func cellText(at index: Int) -> String
    func numberOfRows() -> Int
    func numberOfSections() -> Int
}

final class ViewPresenter {
    private weak var view: ViewControllerInterface?
    private var dataSource = [PlayerItemModel]()
    private let dataBuilder: DataBuilderInterface
    
    init(view: ViewControllerInterface, dataBuilder: DataBuilderInterface = DataBuilder()) {
        self.view = view
        self.dataBuilder = dataBuilder
    }
}

extension ViewPresenter: ViewPresenterInterface {
    func onViewDidLoad() {
        dataSource = dataBuilder.prepareData()

        let avManager = AVManager(player: AVPlayer(), items: dataSource.map { $0.avPlayerItem })
        if avManager.hasItems() {
            view?.configureAVManager(with: avManager)
            view?.configureTableView()
        } else {
            view?.onFailed()
        }
    }

    func cellText(at index: Int) -> String {
        return dataSource[index].title
    }

    func numberOfRows() -> Int {
        return dataSource.count
    }

    func numberOfSections() -> Int {
        return 1
    }
}
