//
//  DataBuilder.swift
//  AVPlayerFun
//
//  Created by Fabio Acri on 05/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import AVFoundation

private enum Videos: String, CaseIterable {
    case Japan
    case Niagara
    case Pozzuoli
}

protocol DataBuilderInterface {
    func prepareData() -> [PlayerItemModel]
}

final class DataBuilder: DataBuilderInterface {
    func prepareData() -> [PlayerItemModel] {
        let itemModels = Videos.allCases.map {
            return makePlayerItemModel(name: $0.rawValue)
        }

        return itemModels
    }
}

private extension DataBuilder {
    func makePlayerItemModel(name: String) -> PlayerItemModel {
        let path: String
        switch name {
        case Videos.Japan.rawValue:
            path = Bundle.main.path(forResource: "JapanKyoto_02", ofType: "mp4") ?? ""
        case Videos.Niagara.rawValue:
            path = Bundle.main.path(forResource: "niagaraFalls_01", ofType: "mp4") ?? ""
        default:
            path = Bundle.main.path(forResource: "PozzuoliBeach", ofType: "mp4") ?? ""
        }

        let asset = AVAsset(url: URL(fileURLWithPath: path))
        let avPlayerItem = AVPlayerItem(asset: asset)

        return PlayerItemModel(title: name, avPlayerItem: avPlayerItem)
    }
}
