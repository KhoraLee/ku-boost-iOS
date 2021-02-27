//
//  GradeView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import Charts
import Combine
import SwiftUI

// MARK: - GradeView

struct GradeView: View {

  @ObservedObject var viewModel = GradeViewModel.shared

  var body: some View {
    GeometryReader{ p in
      ScrollView {
        GradeCardView(
          pieChartEntries: viewModel.currentGradesEntries,
          grades: viewModel.currentGrades,
          proxy: p,
          title:"금학기성적")
        TotalGradeCardView(
          pieChartEntries: viewModel.totalGradesEntries,
          lineChartEntries: viewModel.totalGradeLineEntries,
          proxy: p,
          title:"전체학기성적")
        SimulationCardView(
          simuls: viewModel.graduationSimulation,
          proxy: p,
          title: "졸업시뮬레이션")
          .padding(.bottom)
      }.onAppear {
        viewModel.viewOnAppear()
      }
    }
  }
}

// MARK: - GradeView_Previews

struct GradeView_Previews: PreviewProvider {
  static var previews: some View {
    GradeView()
  }
}
