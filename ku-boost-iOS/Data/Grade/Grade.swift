//
//  Grade.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct Grade : Codable {
    let evaluationMethod: String?  // 성적평가방식
    let semester: String                // 학기
    let classification: String          // 이수구분
    let characterGrade: String?             // 알파벳 성적
    let grade: Float?                      // 성적
    let professor: String?               // 담당교수
    let subjectName: String?        // 과목명
    let subjectNumber: String?         // 학수번호
    let subjectId: String               // 과목 ID
    let subjectPoint: Int?                  // 학점
    
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
