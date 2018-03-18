//
//  DatabaseHelper.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import RealmSwift

class DatabaseHelper {
    static let shared = DatabaseHelper()
    private var realm = try! Realm()
    
    func addEpisode(_ episode: Episode) {
        try! realm.write {
            realm.add(episode, update: true)
        }
    }
    
    func getEpisode(with url: String) -> Episode? {
        return realm.object(ofType: Episode.self, forPrimaryKey: url)
    }
    
    func updateEpisode(_ episode: Episode, with imageUrl: String) {
        try! realm.write {
            episode.imageUrl = imageUrl
        }
    }
}
