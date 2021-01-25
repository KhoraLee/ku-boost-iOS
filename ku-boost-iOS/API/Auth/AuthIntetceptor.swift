//
//  AuthIntetceptor.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Foundation
import Alamofire

final class AuthInterceptor : RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("AuthInterceptor - adapt() called")

        var request = urlRequest
        request.addValue("Cookie", forHTTPHeaderField: UserDefaults.standard.string(forKey: "Cookie")!)

        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("AuthInterceptor - retry() called")
        completion(.doNotRetry)
    }
}
