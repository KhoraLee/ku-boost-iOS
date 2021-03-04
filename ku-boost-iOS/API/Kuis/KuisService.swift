//
//  KuisService.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import Alamofire
import Foundation

class KuisService {

  // MARK: Lifecycle

  private init(){
    //Session 생성
    session = Session(interceptor: interceptors)
  }

  // MARK: Internal

  static let shared = KuisService()

  let interceptors = Interceptor(interceptors : [ KuisInterceptor() ])

  var session: Session
}
