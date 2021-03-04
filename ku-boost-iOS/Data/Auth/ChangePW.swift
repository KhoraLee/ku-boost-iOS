//
//  ChangePW.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation

// MARK: - ChangePW

struct ChangePW: Codable {
  let dmRes: dmRes
}

// MARK: - dmRes

// swiftlint:disable:next type_name
struct dmRes: Codable{
  let flag: String

  enum CodingKeys: String, CodingKey {
    case flag = "FLAG"
  }
}
