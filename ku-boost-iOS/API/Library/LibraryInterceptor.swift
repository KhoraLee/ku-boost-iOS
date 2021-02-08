//
//  LibraryInterceptor.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation
import Alamofire

final class LibraryInterceptor : RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("LibraryInterceptor - adapt() called")

        var request = urlRequest
        request.addValue(UserDefaults.standard.string(forKey: "pyxis-auth-token") ?? "", forHTTPHeaderField:"pyxis-auth-token")
        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("LibraryInterceptor - retry() called")
        completion(.doNotRetry)
    }
}
