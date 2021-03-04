//
//  GraduationSimulation.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct GraduationSimulation: Codable{

  let classification: String? // 이수구분
  let remainder: Int? // 잔여학점
  let acquired: String? // 취득학점
  let standard: Int? // 기준학점

  enum CodingKeys: String, CodingKey {
    case classification = "GRDT_COND_NM"
    case remainder = "MOD_PNT"
    case acquired = "SUM_PNT"
    case standard = "POBT_PNT"
  }

}
