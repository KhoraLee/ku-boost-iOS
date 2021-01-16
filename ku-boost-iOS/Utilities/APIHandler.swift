//
//  APIHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Alamofire
import Combine

class APIHandler {
        
    var statusCode = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
}
