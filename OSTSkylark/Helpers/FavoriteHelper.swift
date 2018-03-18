//
//  FavoriteHelper.swift
//  OSTSkylark
//
//  Created by Ramana on 18/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import Foundation

struct FavoriteHelper {
    private enum FavoriteKeys {
        static let favorite = "favorite"
    }
    
    private static func getFavorites() -> Set<String> {
        var favorties = Set<String>()
        if let values = UserDefaults.standard.value(forKey: FavoriteKeys.favorite) as? [String] {
            favorties = Set(values)
        }
        return favorties
    }
    
    static func isFavorite(_ key: String) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(key)
    }
    
    static func addFavorite(_ key: String) {
        var favorites = getFavorites()
        favorites.insert(key)
        updateFavorites(favorites)
    }
    
    static func removeFavorite(_ key: String) {
        var favorites = getFavorites()
        favorites.remove(key)
        updateFavorites(favorites)
    }
    
    private static func updateFavorites(_ favorites: Set<String>) {
        UserDefaults.standard.set(Array(favorites), forKey: FavoriteKeys.favorite)
        UserDefaults.standard.synchronize()
    }
}
