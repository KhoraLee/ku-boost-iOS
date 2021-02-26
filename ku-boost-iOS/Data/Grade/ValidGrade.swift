//
//  ValidGrade.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct ValidGrade: Codable {
  let subjectId: String

  enum CodingKeys: String, CodingKey {
    case subjectId = "SBJT_ID"
  }
}
