//
//  ChangePasswordViewMode.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/28.
//

import Combine
import PromiseKit
import SwiftUI

class ChangePasswordViewModel: ObservableObject, Identifiable {

  static let shared = ChangePasswordViewModel()

  @Published var isValid = -1 // -1: null, 0: Valid, 1: Same with before, 2: notValid
  @Published var isSame = -1 // -1: null, 0: Same, 1: not Same

  @Published var errMsg = ""
  @Published var alert = false

  var authRepo = AuthRepository.shared

  @Published var bfPassword = ""{
    didSet {
      validatePassword()
    }
  } // before
  @Published var afPassword1 = "" {
    didSet {
      validatePassword()
    }
  }// after
  @Published var afPassword2 = ""{
    didSet {
      checkSame()
    }
  }// after check

  func changePassword() {
    firstly{
      authRepo.makeChangePasswordRequest(
        username: UserDefaults.id,
        before: bfPassword,
        after: afPassword1)
    }.done{
      self.errMsg = ""
      self.alert = true
      LoginViewModel.shared.password = ""
    }.catch{ err in
      guard let error = err as? MyError else {
        self.errMsg = "알수없는 오류\n관리자에게 문의 바랍니다."
        return
      }
      switch error {
      case let .errWithMSG(msg):
        self.errMsg = msg
        print(msg)
      case .noInternet:
        self.errMsg = "네트워크 연결이 없습니다."
      default:
        print("error : \(error)")
        self.errMsg = "알수없는 오류\n관리자에게 문의 바랍니다."
      }
      self.alert = true
    }
  }

  func validatePassword() {
    if afPassword1.isEmpty {
      isValid = -1
      return
    }
    var regexCheck = false
    do{
      let regex = try NSRegularExpression(
        pattern: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~!@#$%>^&*])[A-Za-z\\d$~!@#$%>^&*]{8,20}$")
      regexCheck = regex.firstMatch(
        in: afPassword1,
        range: NSRange(location: 0, length: afPassword1.utf16.count)) != nil
    } catch { }

    if !regexCheck {
      isValid = 2
    } else if bfPassword == afPassword1 {
      isValid = 1
    } else {
      isValid = 0
    }
  }

  func checkSame() {
    if afPassword2.isEmpty {
      isSame = -1
      return
    }
    isSame = afPassword1 == afPassword2 ? 0 : 1
  }

  func clean() {
    bfPassword = ""
    afPassword1 = ""
    afPassword2 = ""
  }

}
