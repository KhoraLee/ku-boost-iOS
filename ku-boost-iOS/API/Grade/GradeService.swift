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
