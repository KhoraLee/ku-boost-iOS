//
//  LoginResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct LoginResponse: Codable {
  let loginSuccess: LoginSuccess?
  let loginFailure: LoginFailure?

  enum CodingKeys: String, CodingKey {
    case loginSuccess = "_METADATA_"
    case loginFailure = "ERRMSGINFO"
  }

}
