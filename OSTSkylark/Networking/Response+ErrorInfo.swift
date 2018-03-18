//
//  Response+ErrorInfo.swift
//  OSTSkylark
//
//  Created by Ramana on 18/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import Alamofire

extension DataResponse {
    
    func errorInfo() -> String? {
        guard let data = self.data,
            let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
            let error = json["error"] as? [String: Any]
            else { return nil }
        let message = error["message"] as? String
        return message
    }
    
}
