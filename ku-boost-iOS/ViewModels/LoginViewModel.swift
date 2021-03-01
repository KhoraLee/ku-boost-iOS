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
      //TODO: change pw or change after 90 days
      default:
        print("error : \(error)")
        self.errMsg = "알수없는 오류\n관리자에게 문의 바랍니다."
      }
      self.gotError = true
    }
  }

  // MARK: Private

  private var disposables: Set<AnyCancellable> = []
}
