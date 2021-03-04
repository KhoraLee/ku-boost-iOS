//
//  LoginViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Combine
import PromiseKit
import SwiftUI

class LoginViewModel: ObservableObject, Identifiable {

  // MARK: Lifecycle

  init() {
    if UserDefaults.id.isEmpty { return }
    guard let pw = keyChain.getPassword() else { return }
    username = UserDefaults.id
    password = pw
    login()
  }

  // MARK: Internal

  static let shared = LoginViewModel()

  @Published var username = ""
  @Published var password = ""

  @Published var isLogon = false
  @Published var isLoading = false

  @Published var errMsg = ""
  @Published var gotError = false
  @Published var error: MyError? = nil

  var authRepo = AuthRepository.shared
  var keyChain = KeyChain.shared

  func login(){
    if username.isEmpty || password.isEmpty { return }
    isLoading = true
    firstly{
      authRepo.makeLoginRequest(username: username, password: password)
    }.then{
      self.authRepo.makeUserInformationRequest()
    }.done{
      UserDefaults.id = self.username
      self.keyChain.storePassword(password: self.password)
      self.username = ""
      self.password = ""
      self.isLoading = false
      self.isLogon = true
    }.catch{err in
      self.isLoading = false
      guard let error = err as? MyError else {
        self.errMsg = "알수없는 오류\n관리자에게 문의 바랍니다."
        return
      }
      switch error {
      case let .errWithMSG(msg):
        self.errMsg = msg
        print(msg)
      case .noInternet:
        if UserDefaults.hasData {
          self.isLogon = true
          return
        } else {
          self.errMsg = "네트워크 연결이 없습니다."
        }
      case .changePwRequired:
        UserDefaults.id = self.username
        self.errMsg = "비밀번호를 변경한지 90일이 지났습니다."
      default:
        print("error : \(error)")
        self.errMsg = "알수없는 오류\n관리자에게 문의 바랍니다."
      }
      self.gotError = true
      self.error = error
    }
  }

  func changeAfter90Days() {
    isLoading = true
    firstly{
      authRepo.makeChangePasswordRequest(username: username, password: password)
    }.done{
      self.isLoading = false
      print("after 90 done")
    }.catch{ err in
      print(err)
    }
  }

  // MARK: Private

  private var disposables: Set<AnyCancellable> = []
}
