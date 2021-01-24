//
//  GradeLogger.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Foundation
import Alamofire

final class GradeLogger : EventMonitor {

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
