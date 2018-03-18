//
//  APIService.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import Alamofire
import ObjectMapper

protocol APIService {
}

extension APIService {
    static func url(_ path: String) -> String {
        return "http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000" + path
    }
}

struct DataService: APIService {
    static func getSets(_ completion: @escaping (DataResponse<SetObject>) -> Void) {
        let urlString = url("/api/sets/?slug=home")
        Alamofire.request(urlString)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                let response: DataResponse<SetObject> = response.flatMapResult { json in
                    if let setObject = Mapper<SetObject>().map(JSONObject: json) {
                        return .success(setObject)
                    } else {
                        let error = MappingError(from: json, to: SetObject.self)
                        print("errorInfo \(String(describing: response.errorInfo()))")
                        return .failure(error)
                    }
                }
                completion(response)
        }
    }
    
    static func getEpisodes( urlString: String, _ completion: @escaping (DataResponse<Episode>) -> Void) {
        let episodeUrl = url(urlString)
        Alamofire.request(episodeUrl)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                let response: DataResponse<Episode> = response.flatMapResult { json in
                    if let episode = Mapper<Episode>().map(JSONObject: json) {
                        return .success(episode)
                    } else {
                        let error = MappingError(from: json, to: SetObject.self)
                        print("errorInfo \(String(describing: response.errorInfo()))")
                        return .failure(error)
                    }
                }
                completion(response)
        }
    }
    
    static func getImage( urlString: String, _ completion: @escaping (DataResponse<ImageData>) -> Void) {
        let imageDataUrl = url(urlString)
        Alamofire.request(imageDataUrl)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                let response: DataResponse<ImageData> = response.flatMapResult { json in
                    if let imageData = Mapper<ImageData>().map(JSONObject: json) {
                        return .success(imageData)
                    } else {
                        let error = MappingError(from: json, to: SetObject.self)
                        print("errorInfo \(String(describing: response.errorInfo()))")
                        return .failure(error)
                    }
                }
                completion(response)
        }
    }
    
}
