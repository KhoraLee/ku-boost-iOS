//
//  ChangePasswordView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/28.
//

import SwiftUI

struct ChangePasswordView: View {

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel = ChangePasswordViewModel.shared

  var bfPasswordTextView: some View {
    SecurePlaceholderTextField(placeholder: Text("현재 비밀번호"), text: $viewModel.bfPassword)
      .padding(.top, 32.0)
  }

  var afPassword1TextView: some View {
    SecurePlaceholderTextField(placeholder: Text("비밀번호"), text: $viewModel.afPassword1)
      .padding(.top, 32.0)
  }

  var afPassword2TextView: some View {
    SecurePlaceholderTextField(placeholder: Text("비밀번호 확인"), text: $viewModel.afPassword2)
      .padding(.top, 32.0)
  }

  var changePWButton: some View {

    Button(action: {
      viewModel.changePassword()
    }, label: {
      VStack {
        Spacer()
        HStack {
          Spacer()
          Text("비밀번호 변경").foregroundColor(.white).fontWeight(.bold)
          Spacer()
        }
        Spacer()
      }.frame(minHeight: 55.0, maxHeight: 55.0)
        .background(viewModel.isValid == 0 && viewModel.isSame == 0 ? Color("primaryColor") : Color.gray)
        .cornerRadius(15)
        .padding(.top, 77.0)
    })
      .disabled(viewModel.isValid != 0 || viewModel.isSame != 0)
  }

  var body: some View {
    VStack{
      HStack{
        BackBtn()
          .padding(.top,15)
          .padding(.leading,20)
        Text("비밀번호 변경")
          .font(.title)
          .fontWeight(.bold)
          .padding([.top,.leading])
        Spacer()
      }
      VStack(alignment:.center){
        bfPasswordTextView
        afPassword1TextView
        switch viewModel.isValid {
        case 1:
          Text("현재 비밀번호와 다른 비밀번호를 입력하세요")
            .font(.caption)
            .foregroundColor(.red)
        case 2:
          Text("8~20자 이내, 하나 이상의 문자, 숫자, 특수 문자를 입력하세요.")
            .font(.caption)
            .foregroundColor(.red)
        default:
          Text("")
        }
        afPassword2TextView
        switch viewModel.isSame {
        case 1:
          Text("패스워드를 다시 확인하세요.")
            .font(.caption)
            .foregroundColor(.red)
        default:
          Text("")
        }
        changePWButton
      }.padding(22)

      Spacer()
    }
    .alert(isPresented: $viewModel.alert) {
      if viewModel.errMsg == "" {
        return Alert(
          title: Text("비빌번호 변경 완료"),
          message: Text("\(viewModel.errMsg)"),
          dismissButton: .default(Text("OK"), action: {
            self.presentationMode.wrappedValue.dismiss()
          }))
      } else {
        return Alert(title: Text("오류"), message: Text("\(viewModel.errMsg)"))
      }
    }
    .navigationBarHidden(true)
    .onAppear{
      viewModel.clean()
    }
  }
}
