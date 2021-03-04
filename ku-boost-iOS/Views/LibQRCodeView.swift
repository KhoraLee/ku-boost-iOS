//
//  LibQRCodeView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/25.
//

import SwiftUI

// MARK: - LibQRCodeView

struct LibQRCodeView: View {

  @ObservedObject var viewModel = SettingViewModel.shared
  @State var stdLen: CGFloat = 0
  @State var nameLen: CGFloat = 0
  @State var deptLen: CGFloat = 0

  var body: some View {
    GeometryReader{ proxy in
      ZStack{
        VStack{
          HStack{
            BackBtn()
              .padding(.top,15)
              .padding(.leading,20)
            Text("모바일 열람증")
              .font(.title)
              .fontWeight(.bold)
              .padding([.top,.leading])
            Spacer()
          }
          Spacer()
        }
        VStack{
          Image(uiImage: viewModel.profileImage)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius:5))
            .overlay(RoundedRectangle(cornerRadius:5).stroke(Color.primary,lineWidth: 1.5))
            .frame(maxHeight:proxy.size.height * 0.25)
          Image(uiImage: viewModel.qrImg)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius:5))
            .frame(width: 180, height: 180)
            .padding()
          VStack(alignment: .leading, spacing: 10){
            TextRow(key: "학번", value: UserDefaults.stdNo)
            TextRow(key: "이름", value: UserDefaults.name)
            TextRow(key: "소속", value: UserDefaults.dept)
          }
        }
        .onAppear{
          viewModel.fetchQRData()
        }
        .navigationBarHidden(true)
      }
    }
  }
}

// MARK: - TextRow

struct TextRow: View {
  var key: String
  var value: String
  var body: some View {
    HStack{
      Text(key)
        .bold()
        .padding(.trailing)
      Text(value)
    }
  }
}
