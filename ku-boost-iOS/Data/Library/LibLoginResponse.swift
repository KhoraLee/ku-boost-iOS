//
//  LoginResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation

// MARK: - LibLoginResponse

struct LibLoginResponse: Codable {
  let data: data?
}

// MARK: - data

// swiftlint:disable:next type_name
struct data: Codable {
  let accessToken: String
}
