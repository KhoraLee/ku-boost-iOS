//
//  MainView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import SwiftUI
import Combine
import Alamofire
import SwiftyJSON

struct MainView: View {
    @State var sid = ""
    var cookie: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Logon Successfully").padding()
            Text(cookie).padding()
            Text(sid).padding()
            Button(action: {
                let reqheaders: HTTPHeaders = ["cookie" : cookie]
                let URL = "https://kuis.konkuk.ac.kr/Main/onLoad.do"
                AF.request(URL, method: .get, headers: reqheaders).responseJSON(){ response in
                    let json = JSON(response.data)
                    sid = json["dmUserInfo"]["USER_ID"].string!
                    print(json)
                }
            }, label: {
                Text("Get info")
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(10)
            })
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(cookie: "-")
    }
}
