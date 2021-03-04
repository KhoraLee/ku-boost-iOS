//
//  GradeResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct GradeResponse: Codable {
  let grades: [Grade]

  enum CodingKeys: String, CodingKey {
    case grades = "DS_GRADEOFSTUDENT"
  }
}
