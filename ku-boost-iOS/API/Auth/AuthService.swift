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
    var session: Session

    private init(){
        print("AuthService - init() called")
        
        // Set-Cookie 해더를 불러와서 UserDefaults에 저장
        let queue = DispatchQueue(label: "com.konkuk.auth-queue", qos: .utility, attributes: [.concurrent]) // AF request를 수행하기 위한 큐
        let semaphore = DispatchSemaphore(value: 0) // 메인 스레드 정지를 위한 세마포어
        AF.request("https://kuis.konkuk.ac.kr/index.do",method: .get).responseJSON(queue: queue){ response in
            let headers = response.response?.allHeaderFields as? [String: Any]
            guard let cookie = headers?["Set-Cookie"] as? String else { return }
            UserDefaults.standard.set(cookie, forKey: "Cookie")
            print("AuthService - Cookie : " + cookie)
            semaphore.signal() // 세마포어에 시그널을 보내 스레드 제게
        }
        semaphore.wait() // 세마포어를 통한 메인 스레드 정지
        
        //Session 생성
        session = Session(interceptor: interceptors /*, eventMonitors: monitors*/)
        print("AuthService - Auth Session created with interceptors")
        
    }
    
}
