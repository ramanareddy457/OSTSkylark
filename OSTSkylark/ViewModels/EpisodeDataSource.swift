//
//  HomeViewModel.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import Foundation

protocol SetObserver: class {
    func setsChanged()
}

class EpisodeDataSource {
    var episodesData: [EpisodeData] {
        didSet {
            notifyObserver()
        }
    }
    
    private var observer: SetObserver?
    
    init() {
        self.episodesData = []
    }
    
    func addObserver(_ observer: SetObserver) {
        self.observer = observer
    }
    
    func removeObserver() {
        observer = nil
    }
    
    private func notifyObserver() {
        DispatchQueue.main.async { [weak self] in
            self?.observer?.setsChanged()
        }
    }
    
    func loadSetData() {
        DataService.getSets { [weak self] response in
            switch response.result {
            case .success(let setObject):
                if let setItem = setObject.setItems.first {
                    self?.episodesData = setItem.items.filter { $0.contentType == "episode" }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
