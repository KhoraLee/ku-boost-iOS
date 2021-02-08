//
//  Grade.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation
import RealmSwift

class Grade : Object, Decodable {
    @objc dynamic var evaluationMethod: String?  // 성적평가방식
    @objc dynamic var semester: String                // 학기
    @objc dynamic var classification: String          // 이수구분
    @objc dynamic var characterGrade: String?             // 알파벳 성적
//    @objc dynamic var grade: Float?                      // 성적
    @objc dynamic var grade: CodableRealmFloat?                      // 성적
    @objc dynamic var professor: String?               // 담당교수
    @objc dynamic var subjectName: String?        // 과목명
    @objc dynamic var subjectNumber: String?         // 학수번호
    @objc dynamic var subjectId: String               // 과목 ID
//    @objc dynamic var subjectPoint: Int                  // 학점
    @objc dynamic var subjectPoint: CodableRealmInt?                  // 학점

//    override class func primaryKey() -> String? {
//        return ""
//    }
    
    enum CodingKeys: String, CodingKey {
        case evaluationMethod = "APPR_MTHD_CD"
        case semester = "COMM_NM"
        case classification = "POBT_NM"
        case characterGrade = "GRD"
        case grade = "MRKS"
        case professor = "KOR_NM"
        case subjectName = "TYPL_KOR_NM"
        case subjectNumber = "HAKSU_ID"
        case subjectId = "SBJT_ID"
        case subjectPoint = "PNT"
    }
}
