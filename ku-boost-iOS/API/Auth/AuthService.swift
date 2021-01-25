//
//  AuthService.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Foundation
import Alamofire

final class AuthService {

    // Singleton
    static let shared = AuthService()

    // Intercepter
    let interceptors = Interceptor(interceptors :
                        [ AuthInterceptor()
                        ])
    // Logger
//    let monitors = [GradeLogger()] as [EventMonitor]


    // Session
    var session = Session()

    private init(){
        //Session 생성
        getCookie{
            self.session = Session(interceptor: self.interceptors /*, eventMonitors: monitors*/)
        }
    }
    
    func getCookie(completion: @escaping (() -> Void)){
        // Set-Cookie 해더를 불러와서 UserDefaults에 저장
        AF.request("https://kuis.konkuk.ac.kr/index.do",method: .get).responseJSON{ response in
            print("reuqested cookie")
    
            let headers = response.response?.allHeaderFields as? [String: Any]
            guard let cookie = headers?["Set-Cookie"] as? String else { return }
            UserDefaults.standard.set(cookie, forKey: "Cookie")
            completion()
        }
    }
}
