//
//  MyError.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/16.
//

public enum MyError: Error {
    
    // MARK: - Internal errors
    case noInternet
    
    // MARK: - API errors
    case badAPIRequest
    
    // MARK: - Auth errors
    case unauthorized
    
    // MARK: - Unknown errors
    case unknown
    
    // MARK: - Json decoding fail errors
    case jsonDecodeFail
    
    // MARK: - Received response that user need to change password
    case changePwRequired
}
