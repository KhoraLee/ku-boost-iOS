//
//  Alamofire.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import Alamofire
import PromiseKit

extension Session {
    /// Triggers an HTTPRequest using alamofire with a promise as a return type
    func requestPromise<T: Codable>(_ urlConvertible: Alamofire.URLRequestConvertible) -> Promise<T> {
        return Promise<T> { seal in
            // Trigger the HTTPRequest using Alamofire
            request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                // Check result from response and map it the the promise
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                case let .failure(error):
                    guard NetworkReachabilityManager()?.isReachable ?? false else {
                        seal.reject(MyError.noInternet)
                        return
                    }
                    if error._code == NSURLErrorTimedOut {
                        print("Request timeout!")
                    }
                    seal.reject(MyError.errWithMSG(msg: "error: \(error),status code : \(response.response?.statusCode ?? -1)"))
                }
            }
        }
    }
}

