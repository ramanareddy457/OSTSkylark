//
//  MappingError.swift
//  OSTSkylark
//
//  Created by Ramana on 18/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

struct MappingError: Error, CustomStringConvertible {
    
    let description: String
    
    init(from: Any?, to: Any.Type) {
        self.description = "Failed to map \(String(describing: from)) to \(to)"
    }
    
}
