//
//  GradeResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation
import RealmSwift

class GradeResponse : Decodable {
    var grades = List<Grade>()
    
    enum CodingKeys: String, CodingKey {
        case grades = "DS_GRADEOFSTUDENT"
    }
}
