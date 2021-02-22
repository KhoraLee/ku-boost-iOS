//
//  KuisService.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import Foundation
import Alamofire

class KuisService {
    static let shared = KuisService()
    
    let interceptors = Interceptor(interceptors : [ KuisInterceptor() ])
    
    var session: Session
    
    private init(){
//        // Set-Cookie 해더를 불러와서 UserDefaults에 저장
//        let queue = DispatchQueue(label: "com.konkuk.auth-queue", qos: .utility, attributes: [.concurrent]) // AF request를 수행하기 위한 큐
//        let semaphore = DispatchSemaphore(value: 0) // 메인 스레드 정지를 위한 세마포어
//        AF.request("https://kuis.konkuk.ac.kr/index.do",method: .get).responseJSON(queue: queue){ response in
//            let headers = response.response?.allHeaderFields as? [String: Any]
//            guard let cookie = headers?["Set-Cookie"] as? String else { return }
//            UserDefaults.cookie = String(cookie.split(separator: ";")[0])
//            semaphore.signal() // 세마포어에 시그널을 보내 스레드 제게
//        }
//        semaphore.wait() // 세마포어를 통한 메인 스레드 정지
        
        //Session 생성
        session = Session(interceptor: interceptors)
        
    }
}
