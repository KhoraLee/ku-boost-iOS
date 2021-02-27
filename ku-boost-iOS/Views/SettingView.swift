//
//  SettingView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import SwiftUI

// MARK: - SettingView

struct SettingView: View {

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel = SettingViewModel.shared
  @State var selected: String?
  @State var osl = false

  var body: some View {
    GeometryReader{ p in
      VStack{
        HStack{
          Text("설정")
            .font(.title)
            .fontWeight(.bold)
            .padding([.top,.leading])
          Spacer()
        }
        // MARK: - Card start
        VStack(alignment: .leading){
          HStack{
            VStack(alignment: .leading){
              // Card view starts here
              HStack{
                RoundedImage(img: viewModel.profileImage, proxy: p)
                VStack(alignment:.leading,spacing:10){
                  Text(UserDefaults.dept)
                    .font(.title3)
                  Text(UserDefaults.name)
                    .font(.title3)
                    .bold()
                }.padding(.leading)
              }
              // End
            }
            .layoutPriority(100)
            Spacer()
          }
          .padding()
        }
        .cornerRadius(10)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(
              Color(
                .sRGB,
                red: 150 / 255,
                green: 150 / 255,
                blue: 150 / 255,
                opacity: 0.5),
              lineWidth: 1)
        )
        .padding([.top, .horizontal])
        // MARK: -
        ZStack{
          VStack{
            SettingBtn(text:"모바일 열람증",sysImg: "qrcode"){
              selected = "lib"
            }.padding()
            SettingBtn(text:"비밀번호 변경",sysImg: "rectangle.and.pencil.and.ellipsis"){
              selected = "changepw"
            }.padding()
            SettingBtn(text:"오픈소스 라이선스",sysImg: "doc.plaintext"){
              selected = "opensource"
            }.padding()
            SettingBtn(text:"로그아웃",sysImg: "escape"){
              viewModel.logout()
              self.presentationMode.wrappedValue.dismiss()
            }.padding()
          }
          VStack{ // VStack only for navigationLink
            NavigationLink(
              destination: LibQRCodeView(),
              tag: "lib",
              selection: $selected,
              label: { EmptyView() })
            NavigationLink(
              destination: ChangePasswordView(),
              tag: "changepw",
              selection: $selected,
              label: { EmptyView() })
            NavigationLink(
              destination: OpenSourceView(osl: viewModel.getOpenSourceLicense()),
              tag: "opensource",
              selection: $selected,
              label: { EmptyView() })
          }.hidden()
        }
        Spacer()
      }.navigationBarHidden(true)
        .onAppear{
          viewModel.getProfileImage()
        }
    }
  }
}

// MARK: - SettingBtn

struct SettingBtn: View {

  var text: String
  var sysImg: String

  @State var textHeight: CGFloat = 0

  var action: () -> Void

  var body: some View {
    Button(action: action){
      HStack{
        Image(systemName: sysImg)
          .resizable()
          .foregroundColor(Color("primaryLightColor"))
          .scaledToFit()
          .frame(width: textHeight, height: textHeight)
          .padding(.leading,5)
        Text(text)
          .foregroundColor(.primary)
          .font(.title2)
          .background(
            GeometryReader { proxy in
              Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
            }
          )
          .onPreferenceChange(SizePreferenceKey.self){ preferences in
            self.textHeight = preferences.height
          }.padding(.leading,7)

        Spacer()
      }
    }
  }
}

// MARK: - RoundedImage

struct RoundedImage: View {
  var img: UIImage
  var proxy: GeometryProxy
  var size: CGFloat

  init(img: UIImage, proxy: GeometryProxy) {
    self.img = img
    self.proxy = proxy
    size = proxy.size.width * 0.2
  }

  var body: some View {
    Image(uiImage: img)
      .resizable()
      .scaledToFill()
      .frame(width: size, height: size, alignment: .center)
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.black, lineWidth: 1))
  }

}
