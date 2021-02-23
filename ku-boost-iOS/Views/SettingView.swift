//
//  SettingView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import SwiftUI

struct SettingView : View {
    @ObservedObject var viewModel = SettingViewModel.shared

    var body: some View {
        VStack{
            // MARK: - Card start
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        // Card view starts here
                        HStack{
                            if viewModel.profileImage == nil{
                                Image(systemName: "goforward")

                            }else {
                                Image(uiImage: UIImage(data:viewModel.profileImage!)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                            }
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
                .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
           )
            .padding([.top, .horizontal])
            // MARK: -
            Spacer()
        }.navigationBarHidden(true)
        .onAppear{
            viewModel.getProfileImage()
        }
    }
}
