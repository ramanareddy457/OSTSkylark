//
//  Episode.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import Realm

class Episode: Object, Mappable {
    private enum CodingKeys {
        static let uid = "uid"
        static let title = "title"
        static let synopsis = "synopsis"
        static let imageUrls = "image_urls"
    }

    @objc dynamic var uid = ""
    @objc dynamic var title = ""
    @objc dynamic var synopsis = ""
    @objc dynamic var imageDataUrl = ""
    @objc dynamic var isFavorite = false
    @objc dynamic var url = ""
    @objc dynamic var imageUrl = ""
    
    var imageUrls: [String] = []
    
    override static func primaryKey() -> String? {
        return "url"
    }
    
    convenience init(with uid: String) {
        self.init()
        self.uid = uid
    }
    
    convenience required init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        uid <- map[CodingKeys.uid]
        title <- map[CodingKeys.title]
        synopsis <- map[CodingKeys.synopsis]
        imageUrls <- map[CodingKeys.imageUrls]
        if imageUrls.count > 0 {
            imageDataUrl = (imageUrls.first)!
        }
    }
    
    
}
