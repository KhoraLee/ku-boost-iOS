//
//  LoginResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation

struct LibLoginResponse: Codable {
    let data: data?
}

struct data: Codable {
    let accessToken: String
}
