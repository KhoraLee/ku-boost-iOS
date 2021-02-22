//
//  AuthRouter.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {

    case Login(id:String, pw:String)
    case UserInfo
    case ChangePassword(id:String, before:String, after:String)
    case ChangeAfter90Day(id:String, pw:String)

    var baseURL: URL {
        return URL(string: "https://kuis.konkuk.ac.kr")!
    }

    var method: HTTPMethod {
        return .get
    }

    var endPoint: String {
        switch self {
        case .Login:
            return "Login/login.do"
        case .UserInfo:
            return "Main/onLoad.do"
        case .ChangePassword, .ChangeAfter90Day:
            return "CmmnPwdChgPop/save.do"
        }
    }

    var parameters : [String: String] {
        switch self {
        case let .Login(id, pw):
            return ["SINGLE_ID":id,
                    "PWD": pw]
        case let .ChangePassword(id,before,after):
            return ["SINGLE_ID" : id,
                    "BF_PWD" : before,
                    "PWD" : after,
                    "PWD1" : after,
                    "PROC_DIV" : ""]
        case let .ChangeAfter90Day(id,pw):
            return ["SINGLE_ID" : id,
                    "BF_PWD" : pw,
                    "PWD" : "",
                    "PWD1" : "",
                    "PROC_DIV" : "PASS"]
        default:
            return ["":""]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method

        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)

        return request
    }
}
