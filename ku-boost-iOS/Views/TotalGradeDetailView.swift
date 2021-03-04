//
//  TotalGradeDetailView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import Foundation
import SwiftUI

struct TotalGradeDetailView: View {

  @ObservedObject var viewModel = GradeViewModel.shared
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  var body: some View {
    GeometryReader{ p in
      VStack {
        ZStack{
          Menu {
            ForEach(viewModel.semesters, id: \.self) { sem in
              Button("\(sem)", action: {
                viewModel.selectedSemester = sem
              })
            }
          } label: {
            Text(viewModel.selectedSemester)
              .fixedSize(horizontal: true, vertical: false)
          }.frame(width: 200, height: 50, alignment: .center)
            .background(Color("primaryLightColor"))
            .foregroundColor(Color.white)
            .cornerRadius(15)
            .padding(.top,10)
          HStack{
            BackBtn()
              .padding(.top,15)
              .padding(.leading,20)
            Spacer()
          }
        }
        GradeCardView(
          pieChartEntries: viewModel.makeSelectedGradeEntries(semester: viewModel.selectedSemester),
          grades: viewModel.getSelectedGrades(semester: viewModel.selectedSemester),
          proxy: p)
      }
    }.navigationBarHidden(true)
  }

}
