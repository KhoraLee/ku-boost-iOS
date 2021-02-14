//
//  GradeView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import SwiftUI
import Combine
import Charts

struct GradeView: View {
    
    @ObservedObject var viewModel = GradeViewModel.shared

    var body: some View {
        GeometryReader{ p in
            ScrollView {
                GradeCardView(pieChartEntries: viewModel.currentGradesEntries, grades: viewModel.currentGrades, proxy: p, title:"금학기성적")
                TotalGradeCardView(pieChartEntries: viewModel.totalGradesEntries, lineChartEntries: viewModel.totalGradeLineEntries, grades: viewModel.totalGrades, proxy: p, title:"전체학기성적")
                    .padding(.bottom,10)
            }
        }
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView()
    }
}
