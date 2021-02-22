//
//  LibraryService.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//


import Foundation
import Alamofire

final class LibraryService {

    // Singleton
    static let shared = LibraryService()

    // Intercepter
    let interceptors = Interceptor(interceptors : [ LibraryInterceptor() ])

    // Session
    var session : Session

    private init(){
        session = Session(interceptor:interceptors)
    }
    
}
