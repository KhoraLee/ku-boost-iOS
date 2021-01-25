//
//  LoginHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Combine
import Alamofire
import SwiftyJSON

class LoginHandler {

    @Published var isLoading = false
    @Published var cookie = ""
    @Published var isLogon = false

    let Alamo : Session

    init(){
        Alamo = AuthService.shared.session
    }
    
    
    func doLogin(id:String, passwd:String) {
        isLoading = true
               
        Alamo.request(AuthRouter.Login(id: id, pw: passwd)).responseJSON{ [weak self] (login) in
            guard let weakSelf = self else { return }
            let loginJSON = JSON(login.data)
            if(loginJSON["_METADATA_"]["success"].boolValue){
                weakSelf.Alamo.request(AuthRouter.UserInfo).responseJSON{ info in
                    let infoJSON = JSON(info.data)
                    if let stdNo = infoJSON["dmUserInfo"]["USER_ID"].string {
                        UserDefaults.standard.set(infoJSON["dmUserInfo"]["SHREG_CD"].string, forKey: "shreg")
                        UserDefaults.standard.set(stdNo, forKey: "stdNo")

                        weakSelf.isLogon = true
                        weakSelf.isLoading = false
                        return
                    }
                }
            }
            weakSelf.isLoading = false
            return
        }
    }
}
