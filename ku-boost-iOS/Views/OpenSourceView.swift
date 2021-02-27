//
//  OpenSourceView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/28.
//

import SwiftUI

struct OpenSourceView: View {

  var osl: String

  var body: some View {
    VStack {
      HStack{
        BackBtn()
          .padding(.top,15)
          .padding(.leading,20)
        Text("오픈소스 라이선스")
          .font(.title)
          .fontWeight(.bold)
          .padding([.top,.leading])
        Spacer()
      }
      ScrollView {
        Text(osl)
          .frame(maxWidth:.infinity)
          .padding()
      }
    }.navigationBarHidden(true)
  }
}
