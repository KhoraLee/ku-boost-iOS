//
//  LoginHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Combine
import Alamofire
import PromiseKit

class AuthHandler {
    
    static let shared = AuthHandler()

    @Published var isLoading = false
    @Published var isLogon = false

    let Alamo = AuthService.shared.session
    
    func login(id:String, passwd:String) {
        print("AuthHandler - login() called")
        isLoading = true
        
        firstly{
            requestLogin(id: id, passwd: passwd)
        }.then{ loginJson -> Promise<Bool> in
            if loginJson._METADATA_?.success == true {
                // ID/PW 저장 및 자동 로그인 활성화
                let ud = UserDefaults.standard
                ud.set(id, forKey: "id")
                ud.set(passwd,forKey: "pw")
                ud.set(true, forKey: "autologin")
                return Promise{ s in s.fulfill(true)}
            } else if loginJson.ERRMSGINFO?.ERRMSG == "SYS.CMMN@CMMN018" {
                return Promise{ s in s.reject( MyError.changePwRequired)}
            }
            return Promise{ s in s.reject( MyError.unknown)}
        }.then{ _ in
            self.fetchUserInformation()
        }.done{ result in
            let infoJson = result
            // UserDefaults에 기본 정보 저장
            let ud = UserDefaults.standard
            let info = infoJson.dmUserInfo
            ud.setValue(info.name, forKey: "name")
            ud.setValue(info.stdNo, forKey: "stdNo")
            ud.setValue(info.state, forKey: "state")
            ud.setValue(info.dept, forKey: "dept")
            ud.setValue(info.code, forKey: "code")
            // 로그인이 성공함을 뷰에 알림
            self.isLoading = false
            self.isLogon = true
        }.catch{ error in
            // 로그인에 실패하였음으로 로딩표시만 끄도록 뷰에 알림
            self.isLoading = false
            print("catch \(error)")
        }
    }
    
    func requestLogin(id:String, passwd:String) -> Promise<LoginResponse> {
        print("requestLogin")
        return Promise<LoginResponse> { seal in
            // Trigger the HTTPRequest using Alamofire
            Alamo.request(AuthRouter.Login(id: id, pw: passwd)).responseJSON{ login in
                switch login.result {
                case .success(let data):
                    do{
                        let loginJson = try JSONDecoder().decode(LoginResponse.self, from: JSONSerialization.data(withJSONObject: data))
                        seal.fulfill(loginJson)
                    } catch {
                        seal.reject(MyError.jsonDecodeFail)
                    }
                case .failure:
                    // If it's a failure, check status code and map it to my error
                    switch login.response?.statusCode {
                    case 400:
                        seal.reject(MyError.badAPIRequest)
                    case 401:
                        seal.reject(MyError.unauthorized)
                    default:
                        guard NetworkReachabilityManager()?.isReachable ?? false else {
                            seal.reject(MyError.noInternet)
                            return
                        }
                        seal.reject(MyError.unknown)
                    }
                }
            }
        }
    }
    
    func fetchUserInformation() -> Promise<UserInfo> {
        print("AuthHandler - fetchUserInformation2() called")
        return Promise<UserInfo> { seal in
            // Trigger the HTTPRequest using Alamofire
            Alamo.request(AuthRouter.UserInfo).responseJSON{ info in
                switch info.result {
                case .success(let data):
                    do{
                        let infoJson = try JSONDecoder().decode(UserInfo.self, from: JSONSerialization.data(withJSONObject: data))
                        seal.fulfill(infoJson)
                    } catch {
                        seal.reject(MyError.jsonDecodeFail)
                    }
                case .failure:
                    // If it's a failure, check status code and map it to my error
                    switch info.response?.statusCode {
                    case 400:
                        seal.reject(MyError.badAPIRequest)
                    case 401:
                        seal.reject(MyError.unauthorized)
                    default:
                        guard NetworkReachabilityManager()?.isReachable ?? false else {
                            seal.reject(MyError.noInternet)
                            return
                        }
                        seal.reject(MyError.unknown)
                    }
                }
            }
        }
    }
    
    //TODO: 이후에 PromiseKit에 적용되도록 수정 필요
    
    func changePassword(){
        print("AuthHandler - changePassword() called")
        isLoading = true
               
        Alamo.request(AuthRouter.ChangeAfter90Day).responseJSON{ [weak self] (info) in
            guard let weakSelf = self else { return }
            switch info.result{
            case .success(let data):
                do{
                    let flagJson = try JSONDecoder().decode(ChangePW.self, from: JSONSerialization.data(withJSONObject: data))
                    if flagJson.dmRes.flag == "1"{
                        // TODO :
                    }
                } catch(let error){
                    debugPrint(error)
                }
            case .failure(let err):
                debugPrint(err)
            }
            weakSelf.isLoading = false
            return
        }
    }
    
    func changePassword(pw: String){
        print("AuthHandler - changePassword(pw) called")
        isLoading = true
               
        Alamo.request(AuthRouter.ChangePassword(pw: pw)).responseJSON{ [weak self] (info) in
            guard let weakSelf = self else { return }
            switch info.result{
            case .success(let data):
                do{
                    let flagJson = try JSONDecoder().decode(ChangePW.self, from: JSONSerialization.data(withJSONObject: data))
                    if flagJson.dmRes.flag == "1"{
                        // TODO :
                    }
                } catch(let error){
                    debugPrint(error)
                }
            case .failure(let err):
                debugPrint(err)
            }
            weakSelf.isLoading = false
            return
        }
    }
}
