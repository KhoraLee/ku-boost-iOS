//
//  KuisInterceptor.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import Alamofire

final class KuisInterceptor: RequestInterceptor {

  func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void)
  {
    var request = urlRequest
//        request.addValue("Cookie", forHTTPHeaderField: UserDefaults.cookie)
    request.timeoutInterval = 10
    completion(.success(request))
  }

  func retry(
    _ request: Request,
    for session: Session,
    dueTo error: Error,
    completion: @escaping (RetryResult) -> Void)
  {
    completion(.doNotRetry)
  }
}
