//
//  AuthRepository.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import PromiseKit

class AuthRepository {

  static let shared = AuthRepository()

  let api = KuisService.shared.session

  func makeLoginRequest(username: String, password: String) -> Promise<Void> {
    Promise{ seal in
      api.request(AuthRouter.Index).response{ _ in
        seal.fulfill(())
      }
    }.then{
      self.api.requestPromise(AuthRouter.Login(id: username, pw: password))
    }.done{ (result: LoginResponse) in
      let loginSuccess = result.loginSuccess
      let loginFailure = result.loginFailure
      if loginSuccess?.success == true {
        return
      } else if loginSuccess == nil && loginFailure != nil {
        throw MyError.errWithMSG(msg: loginFailure!.ERRMSG)
      } else {
        throw MyError.unknown
      }
    }
  }

  func makeLogoutRequset() {
    UserDefaults.clearAll()
    LoginViewModel.shared.isLogon = false
    GradeViewModel.shared.fetched = false
    SimulationViewModel.shared.fetched = false
    SettingViewModel.shared.fetched = false
  }

  func makeChangePasswordRequest(username: String, password: String) -> Promise<Void> {
    Promise{ seal in
      api.requestPromise(AuthRouter.ChangeAfter90Day(id:username,pw:password))
        .done { (result: ChangePW) in
          let flag = result.dmRes.flag
          switch flag {
          case "1":
            seal.reject(MyError.errWithMSG(msg: "비밀번호 불일치"))
          case "PASS":
            seal.fulfill(())
          default:
            seal.reject(MyError.unknown)
          }
        }.catch{ err in
          seal.reject(err)
        }
    }
  }

  func makeChangePasswordRequest(username: String, before: String, after: String) -> Promise<Void> {
    Promise{ seal in
      api.requestPromise(AuthRouter.ChangePassword(id: username, before: before, after: after))
        .done { (result: ChangePW) in
          let flag = result.dmRes.flag
          switch flag {
          case "1":
            seal.reject(MyError.errWithMSG(msg: "비밀번호 불일치"))
          case "3":
            seal.fulfill(())
          default:
            seal.reject(MyError.unknown)
          }
        }.catch{ err in
          seal.reject(err)
        }
    }
  }

  func makeUserInformationRequest() -> Promise<Void> {
    Promise{ seal in
      api.requestPromise(AuthRouter.UserInfo).done{ (result: UserInfo) in
        let info = result.dmUserInfo
        UserDefaults.setUserInfo(
          name: info.name,
          stdNo: info.stdNo,
          state: info.state,
          dept: info.dept,
          code: info.code)
        seal.fulfill(())
      }.catch{ err in
        seal.reject(err)
      }
    }
  }

  func makeStudentInformationRequest() -> Promise<Void> {
    api.requestPromise(AuthRouter.PersonalInfo).done{ (result: StudentInfoResponse) in
      UserDefaults.photo = result.profilePhoto.profilePhoto
    }
  }

  func getName() -> String { UserDefaults.name }

  func getDept() -> String { UserDefaults.dept }

  func getStdNo() -> String { UserDefaults.stdNo }

}
