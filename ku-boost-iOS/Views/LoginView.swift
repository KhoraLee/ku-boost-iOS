//
//  LoginView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import SwiftUI

// MARK: - LoginView

struct LoginView: View {

  // MARK: Internal

  @ObservedObject var viewModel = LoginViewModel.shared
  @State var changePW = false

  var loginButton: some View {
    NavigationLink(
      destination: MainView().navigationBarHidden(true),
      isActive: .constant($viewModel.isLogon.wrappedValue == true)) {
        VStack {
          Spacer()
          HStack {
            Spacer()
            Text("로그인").foregroundColor(.white).fontWeight(.bold)
            Spacer()
          }
          Spacer()
        }.frame(minHeight: 55.0, maxHeight: 55.0)
          .background(Color("primaryColor"))
          .cornerRadius(15)
          .padding(.top, 77.0)

    }.simultaneousGesture(TapGesture().onEnded{
      self.loginUser()
    })
      .alert(isPresented: $viewModel.gotError) {
        if viewModel.error == .changePwRequired {
          return Alert(
            title: Text("오류"),
            message: Text("\(viewModel.errMsg)"),
            primaryButton: .default(
              Text("90일뒤 변경"),
              action: {
                viewModel.changeAfter90Days()
              }),
            secondaryButton:.default(
              Text("비밀번호 변경"), action: {
                changePW = true
              }))
        } else {
          return Alert(title: Text("오류"), message: Text("\(viewModel.errMsg)"))
        }
      }
  }

  var placeHolderTextView: some View {
    PlaceholderTextField(placeholder: Text("포탈 아이디"), text: $viewModel.username)
      .padding(.top, 32.0)
  }

  var passwordTextView: some View {
    SecurePlaceholderTextField(placeholder: Text("비밀번호"), text: $viewModel.password)
      .padding(.top, 32.0)
  }

  var titleView: some View {
    VStack(alignment: .center) {
      Image("Logo")
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
        .foregroundColor(Color("LogoColor"))
    }.padding(EdgeInsets(top: 14.0, leading: .zero, bottom: 10, trailing: .zero))
  }

  var body: some View {
    NavigationView {
      LoadingView(isShowing: .constant(viewModel.isLoading)) {
        ZStack{
          VStack(alignment: .center) {
            self.titleView
            self.placeHolderTextView
            self.passwordTextView
            self.loginButton
            Spacer()
            Spacer()
          }.padding(22.0)
          NavigationLink(
            destination: ChangePasswordView(),
            isActive: $changePW,
            label: {
              EmptyView()
            })
        }
      }
    }

  }

  // MARK: Private

  private func loginUser() {
    viewModel.login()
  }
}

// MARK: - LoginView_Previews

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
