//
//  LibLoginRequest.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation

struct LibLoginRequest: Codable{
  let loginId: String
  let password: String
  let isMobile: Bool
}
