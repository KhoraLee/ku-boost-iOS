//
//  LibraryRouter.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Alamofire
import Foundation

enum LibraryRouter: URLRequestConvertible {

  case login
  case getMobileQRCode

  // MARK: Internal

  var baseURL: URL {
    URL(string: "https://library.konkuk.ac.kr/")!
  }

  var method: HTTPMethod {
    switch self {
    case .login:
      return .post
    case .getMobileQRCode:
      return .get
    }
  }

  var endPoint: String {
    switch self {
    case .login:
      return "pyxis-api/api/login"
    case .getMobileQRCode:
      return "pyxis-api/9/api/my-membership-card"
    }
  }

  func asURLRequest() throws -> URLRequest {
    let url = baseURL.appendingPathComponent(endPoint)
    var request = URLRequest(url: url)
    request.method = method

    switch self {
    case .login:
      let ud: UserDefaults = .standard
      request = try JSONParameterEncoder()
        .encode(
          LibLoginRequest(
            loginId: ud.string(forKey: "id")!,
            password: ud.string(forKey: "pw")!,
            isMobile: true),
          into: request)
    default:
      break
    }

    return request
  }
}
