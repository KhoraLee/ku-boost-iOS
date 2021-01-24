//
//  GradeRouter.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Foundation
import Alamofire

enum GradeRouter: URLRequestConvertible {

    case GradeSimul
    case RegularGrade(year: Int, semester: Int)
    case ValidGrade(year: Int, semester: Int)

    var baseURL: URL {
        return URL(string: "https://kuis.konkuk.ac.kr")!
    }

    var method: HTTPMethod {
        return .get
    }

    var endPoint: String {
        switch self {
        case .GradeSimul:
            return "GrdtStdSimul/findSearch2.do"
        case .RegularGrade:
            return "GradNowShtmGradeInq/find.do"
        case .ValidGrade:
            return "GradGiveUpApp/findUpDown.do"
        }
    }

    var parameters : [String: String] {
        switch self {
        case .GradeSimul:
            return ["shregCd":UserDefaults.standard.string(forKey: "shreg")!,
                    "corsYy":"2020",
                    "stdNo":UserDefaults.standard.string(forKey: "stdNo")!,
                    "_AUTH_MENU_KEY":"1170201"]
            
        case let .RegularGrade(year, semester):
            let format = DateFormatter()
            format.dateFormat = "yyyyMMdd"

            return ["stdNo":UserDefaults.standard.string(forKey: "stdNo")!,
                    "basiYy": String(year),
                    "basiShtm": "B0101"+String(semester),
                    "curDate":format.string(from: Date()),
                    "_AUTH_MENU_KEY":"1140302"]
            
        case let .ValidGrade(year, semester):
            return ["argStdNo":UserDefaults.standard.string(forKey: "stdNo")!,
                    "argYy": String(year),
                    "argShtm": "B0101"+String(semester),
                    "_AUTH_MENU_KEY":"1140606"]
            
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
