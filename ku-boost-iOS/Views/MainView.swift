//
//  MainView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import SwiftUI
import Combine
import Alamofire

struct MainView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Logon Successfully").padding()
            Button(action: {
//                let gh = GradeHandler()
//                gh.fetchRegularGrade(year: 2020, semester: 1)
//                gh.fetchRegularGrade(year: 2020, semester: 2)
                AuthHandler.shared.fetchUserInformation()
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
        MainView()
    }
}
