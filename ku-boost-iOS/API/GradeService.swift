//
//  GradeService.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Foundation
import Alamofire

final class GradeService {

    // Singleton
    static let shared = GradeService()

    // Intercepter
    let interceptors = Interceptor(interceptors :
                        [ GradeInterceptor()
                        ])
    // Logger
    let monitors = [GradeLogger()] as [EventMonitor]


    // Session
    var session : Session

    private init(){
        session = Session(interceptor:interceptors, eventMonitors: monitors)
    }
}

class GradeInterceptor : RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("GradeInterceptor - adapt() called")

        var request = urlRequest
        request.addValue("Cookie", forHTTPHeaderField: UserDefaults.standard.string(forKey: "Cookie")!)

        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("GradeInterceptor - retry() called")
        completion(.doNotRetry)
    }
}

class GradeLogger : EventMonitor {

    let queue = DispatchQueue(label: "GradeLog")

    func requestDidResume(_ request: Request) {
        print("GradeLogger - requestDidResume() called")
        debugPrint(request)
    }

    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("GradeLogger - request.didParseResponse() called")
        debugPrint(request)
    }

}

enum GradeRouter: URLRequestConvertible {

    case GradeSimul
    case RegularGrade(year: Int, semester: Int)
//    case ValidGrade()

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
