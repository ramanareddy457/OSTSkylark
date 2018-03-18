//
//  SetItem.swift
//  OSTSkylark
//
//  Created by Ramana on 18/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import ObjectMapper
import RealmSwift
import Realm

struct SetObject: Mappable {
    
    private enum CodingKeys {
        static let objects = "objects"
    }
    var setItems: [SetItem] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        setItems <- map[CodingKeys.objects]
    }
}

struct SetItem: Mappable {
        private enum CodingKeys {
            static let items = "items"
        }
    var items: [EpisodeData]!

    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        items <- map[CodingKeys.items]
    }
}

struct EpisodeData: Mappable {
    private enum CodingKeys {
        static let contentType = "content_type"
        static let contentUrl = "content_url"
    }
    var contentType = ""
    var contentUrl = ""
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        contentType <- map[CodingKeys.contentType]
        contentUrl <- map[CodingKeys.contentUrl]
    }
}

struct ImageData: Mappable {
    private enum CodingKeys {
        static let imageUrl = "url"
    }
    
    var imageUrl = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        imageUrl <- map[CodingKeys.imageUrl]
    }
}
