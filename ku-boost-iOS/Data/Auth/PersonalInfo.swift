//
//  PersonalInfo.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import Foundation

struct PersonalInfo: Codable {

  enum CodingKeys: String, CodingKey {
    case zipCode = "ZIP"
    case cellPhoneNo = "HAND_NO"
    case enterDate = "ENTR_DT"
    case chineseName = "CHA_NM"
    case schoolYear = "SHYR"
    case email = "EMAIL"
    case highSchoolName = "HSCH_NM"
    case universityName = "UNIV_NM"
    case gender = "GEN"
    case highSchoolGraduationDate = "NATV_HSCH_GRDT_DT"
    case earlyGraduationAvailability = "EALY_GRDT_CHECK"
    case country = "COUN_CD"
    case tellNo = "TEL_NO"
    case koreanName = "KOR_NM"
    case englishName = "ENG_NM"
    case birthday = "BIRTH_DT"
    case studentDiv = "STD_DIV"
    case enterCode = "ENTR_CD"
    case address = "ADDR"
    case impairment = "HANDICAP_FG"
  }

  let zipCode: String? // 우편번호
  let cellPhoneNo: String? // 핸드폰번호
  let enterDate: String?   // 입학일자 (yyyy/MM/dd)
  let chineseName: String?  // 한자이름
  let schoolYear: String // 학년
  let email: String? // 이메일
  let highSchoolName: String? // 출신 고등학교 이름
  let universityName: String? // 출신 대학교 이름
  let gender: String? // 성별
  let highSchoolGraduationDate: String? // 고등학교 졸업일자
  let earlyGraduationAvailability: String? // 조기졸업여부
  let country: String? // 국적
  let tellNo: String? // 집 전화번호
  let koreanName: String? // 한글이름
  let englishName: String? // 영어이름
  let birthday: String? // 생일 (yyMMdd)
  let studentDiv: String? // 학생구분
  let enterCode: String? // 입학구분
  let address: String? // 주소
  let impairment: String? // 장애여부
}
