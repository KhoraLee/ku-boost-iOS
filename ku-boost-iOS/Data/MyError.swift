//
//  MyError.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/16.
//

public enum MyError: Error, Equatable {

  // MARK: - Internal errors
  case noInternet

  // MARK: - Unknown errors
  case unknown

  // MARK: - Json decoding fail errors
  case jsonDecodeFail

  // MARK: - Received response that user need to change password
  case changePwRequired

  // MARK: - Error that contain error message
  case errWithMSG(msg: String)
}
