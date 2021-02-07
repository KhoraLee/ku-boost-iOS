//
//  UserInfo.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct UserInfo: Codable {
    let dmUserInfo:dmUserInfo
}

struct dmUserInfo: Codable{
    
    let stdNo: String? // ex) 202011339
    let state: String? // ex) 재학생
    let dept: String? // ex) 공과대학 컴퓨터공학부
    let name: String? // ex) 이승윤
    let code: String? // ex) A08001
    
    enum CodingKeys: String, CodingKey {
        case stdNo = "USER_ID"
        case state = "SHREG_NM"
        case dept = "DEPT_TTNM"
        case name = "USER_NM"
        case code = "SHREG_CD"
    }

}
