//
//  LoginHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Combine
import Alamofire

class AuthHandler {
    
    static let shared = AuthHandler()

    @Published var isLoading = false
    @Published var isLogon = false

    let Alamo = AuthService.shared.session
    
    func login(id:String, passwd:String) {
        print("AuthHandler - login() called")
        isLoading = true
               
        Alamo.request(AuthRouter.Login(id: id, pw: passwd)).responseJSON{ [weak self] (login) in
            guard let weakSelf = self else { return }
            switch login.result{
            case .success(let data):
                do{
                    let loginJson = try JSONDecoder().decode(LoginResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    if loginJson._METADATA_?.success == true {
                        // ID/PW 저장 및 자동 로그인 활성화
                        let ud = UserDefaults.standard
                        ud.set(id, forKey: "id")
                        ud.set(passwd,forKey: "pw")
                        ud.set(true, forKey: "autologin")
                        
                        AuthHandler.shared.fetchUserInformation() // TODO : Need async

                        weakSelf.isLogon = true
                        weakSelf.isLoading = false
                        return
                    } else if loginJson.ERRMSGINFO?.ERRMSG == "SYS.CMMN@CMMN018" { // 비밀번호 변경후 90일이 지났다는 오류
                        let ud = UserDefaults.standard
                        ud.set(id, forKey: "id")
                        ud.set(passwd,forKey: "pw")
                        
                        weakSelf.isLogon = false
                        weakSelf.isLoading = false
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
    
    func fetchUserInformation(){
        print("AuthHandler - fetchUserInformation() called")
        isLoading = true
               
        Alamo.request(AuthRouter.UserInfo).responseJSON{ [weak self] (info) in
            guard let weakSelf = self else { return }
            switch info.result{
            case .success(let data):
                do{
                    let infoJson = try JSONDecoder().decode(UserInfo.self, from: JSONSerialization.data(withJSONObject: data))
                    
                    // UserDefaults에 기본 정보 저장
                    let ud = UserDefaults.standard
                    let info = infoJson.dmUserInfo
                    guard let name = info.name,
                          let stdNo = info.stdNo,
                          let state = info.state,
                          let dept = info.dept,
                          let code = info.code else { return }
                    
                    ud.setValue(name, forKey: "name")
                    ud.setValue(stdNo, forKey: "stdNo")
                    ud.setValue(state, forKey: "state")
                    ud.setValue(dept, forKey: "dept")
                    ud.setValue(code, forKey: "code")
                    
                    print(infoJson)
                    print("\n")
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
