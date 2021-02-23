//
//  ProfilePhoto.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import Foundation

struct ProfilePhoto: Codable{
    let profilePhoto: String
    
    enum CodingKeys: String, CodingKey {
        case profilePhoto = "PHOTO"
    }
}
