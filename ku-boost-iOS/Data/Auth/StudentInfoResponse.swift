//
//  StudentInfoResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import Foundation

struct StudentInfoResponse: Codable {
    let personalInfo: [PersonalInfo] // 인적사항
    let profilePhoto: ProfilePhoto // 프로필 사진 (base 64 디코딩)
    
    enum CodingKeys: String, CodingKey {
        case personalInfo = "DS_REGI110"
        case profilePhoto = "dmPhoto"
    }
}
