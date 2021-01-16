//
//  LoginHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Combine
import Alamofire
import SwiftyJSON

class LoginHandler: APIHandler {

    @Published var isLoading = false
    @Published var cookie = ""
    @Published var isLogon = false

    func getCookie() {

    }
    
    func doLogin(id:String, passwd:String) {
        isLoading = true
        let cookieURL = "https://kuis.konkuk.ac.kr/index.do"
        let loginURL = "https://kuis.konkuk.ac.kr/Login/login.do?%40d1%23SINGLE_ID=" + id + "&%40d1%23PWD=" + passwd + "&%40d1%23default.locale=ko&%40d%23=%40d1%23&%40d1%23=dsParam&%40d1%23tp=dm&"
        let reqheaders: HTTPHeaders = ["cookie":""]

        
        AF.request(cookieURL, method: .get, headers: reqheaders).responseJSON{ [weak self] (response) in
            guard let weakSelf = self else { return }
            response.response?.allHeaderFields
            let headers = response.response?.allHeaderFields as? [String: Any]
            guard let cookie = headers?["Set-Cookie"] as? String else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.cookie = cookie
            // Getting Cookie End
            // Start login process
            let reqheaders: HTTPHeaders = ["cookie" : cookie]
            AF.request(loginURL, method: .get, headers: reqheaders).responseJSON(){ [weak self] (response) in
                guard let weakSelf = self else { return }
                let json = JSON(response.data)
                if(json["_METADATA_"]["success"].boolValue){
                    weakSelf.isLogon = true
                    weakSelf.isLoading = false
                    return
                }
                weakSelf.isLoading = false
                return
            }
        }
        

    }
}
