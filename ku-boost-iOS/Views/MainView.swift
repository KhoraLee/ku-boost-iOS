//
//  MainView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import Combine
import SwiftUI

// MARK: - MainView

struct MainView: View {

  var body: some View {
    TabView{
      GradeView()
        .tabItem {
          Image(systemName: "square.and.pencil")
          Text("성적")
        }
        .navigationBarHidden(true)
      SettingView()
        .tabItem {
          Image(systemName: "gearshape")
          Text("설정")
        }
    }
    .accentColor(Color("primaryLightColor"))
  }

}

// MARK: - MainView_Previews

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
