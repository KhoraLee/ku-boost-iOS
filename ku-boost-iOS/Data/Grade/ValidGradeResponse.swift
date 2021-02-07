//
//  ValidGradeResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct ValidGradeResponse : Codable {
    let validGrades: [ValidGrade]
    
    enum CodingKeys: String, CodingKey {
        case validGrades = "DS_UPPER"
    }
}
