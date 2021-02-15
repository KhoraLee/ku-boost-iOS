//
//  LibraryRouter.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation
import Alamofire

enum LibraryRouter: URLRequestConvertible {

    case login(id:String, pw:String)
    case getMobileQRCode

    var baseURL: URL {
        return URL(string: "https://library.konkuk.ac.kr/")!
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
            case let .login(id,pw):
                request = try JSONParameterEncoder().encode(LibLoginRequest(loginId: id, password: pw, isMobile: true), into: request)
            default:
                break
        }
        
        return request
    }
}