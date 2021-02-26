//
//  RealmGrade.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation
import RealmSwift

class RealmGrade: Object {
  @objc dynamic var stdNo: String = "" // 학번
  @objc dynamic var year: Int = 0000 // 년도
  @objc dynamic var semester: Int = 0 // 학기
  @objc dynamic var evaluationMethod: String = "" // 성적평가방식
  @objc dynamic var classification: String = "" // 이수구분
  @objc dynamic var characterGrade: String = "" // 알파벳 성적
  let grade = RealmOptional<Float>() // 성적
  @objc dynamic var professor: String = ""  // 담당교수
  @objc dynamic var subjectName: String = ""  // 과목명
  @objc dynamic var subjectNumber: String = ""  // 학수번호
  @objc dynamic var subjectId: String = ""  // 과목 ID
  @objc dynamic var subjectArea: String = "" // 과목 분류 ex) 글로벌인재양성, 사고력증진, 학문소양및인성함양...
  let subjectPoint = RealmOptional<Int>() // 학점
  @objc dynamic var valid = false // 유효한 성적 여부

  @objc dynamic var compoundKey = "" // Compound Key

  override class func primaryKey() -> String? {
    "compoundKey"
  }

  func setup(year: Int, semester: Int, grade: Grade){
    stdNo = UserDefaults.stdNo
    self.year = year
    self.semester = semester
    evaluationMethod = grade.evaluationMethod ?? ""
    classification = grade.classification
    characterGrade = grade.characterGrade ?? ""
    self.grade.value = grade.grade
    professor = grade.professor ?? ""
    subjectName = grade.subjectName ?? ""
    subjectNumber = grade.subjectNumber ?? ""
    subjectId = grade.subjectId
    subjectPoint.value = grade.subjectPoint

    compoundKey = compoundKeyValue()
  }

  func validate(){
    valid = true
  }

  func compoundKeyValue() -> String {
    "\(stdNo)-\(year)-\(semester)-\(subjectId)"
  }

}
