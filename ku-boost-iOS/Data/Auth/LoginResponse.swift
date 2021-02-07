//
//  LoginResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct LoginResponse: Codable {
    let _METADATA_: LoginSuccess?
    let ERRMSGINFO: LoginFailure?
}
