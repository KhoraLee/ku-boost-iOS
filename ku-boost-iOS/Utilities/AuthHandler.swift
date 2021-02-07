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
                        
                        weakSelf.isLogon = true
                        weakSelf.isLoading = false
                        return
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
                    print(infoJson)
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
