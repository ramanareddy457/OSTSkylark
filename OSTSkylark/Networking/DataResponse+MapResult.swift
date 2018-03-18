//
//  DataResponse+MapResult.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import Alamofire

extension DataResponse {
    func mapResult<T>(_ transform: (Value) -> T) -> DataResponse<T> {
        return self.flatMapResult { value in .success(transform(value)) }
    }
    
    func flatMapResult<T>(_ transform: (Value) -> Result<T>) -> DataResponse<T> {
        let result: Result<T>
        switch self.result {
        case .success(let value):
            result = transform(value)
        case .failure(let error):
            result = .failure(error)
        }
        return DataResponse<T>(
            request: self.request,
            response: self.response,
            data: self.data,
            result: result,
            timeline: self.timeline
        )
        
    }
    
}
