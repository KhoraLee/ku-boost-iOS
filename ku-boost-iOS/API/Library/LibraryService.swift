//
//  LibraryService.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/25.
//

import Alamofire
import Foundation

final class LibraryService {

  // MARK: Lifecycle

  private init(){
    session = Session(interceptor:interceptors)
  }

  // MARK: Internal

  // Singleton
  static let shared = LibraryService()

  // Intercepter
  let interceptors = Interceptor(interceptors : [ LibraryInterceptor() ])

  // Session
  var session: Session

}
