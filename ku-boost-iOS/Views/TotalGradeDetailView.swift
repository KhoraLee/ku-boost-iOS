//
//  TotalGradeDetailView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import Foundation
import SwiftUI

struct TotalGradeDetailView: View {
    
    @State var selectedSemester = "2020년 1학기"
    @ObservedObject var viewModel = GradeViewModel.shared

    var body: some View {
        GeometryReader{ p in
            ScrollView {
                
//
//                Menu("\(selectedSemester)"){
//                    ForEach(viewModel.currentGrades, id: \.compoundKey) { grade in
//                        Button("\(grade.semester)", action: {
//                            print(grade.subjectName)
//                        })
//                    }
//                }
//                .padding(.all,5)
//                .background(Color.green)
//                .cornerRadius(15)
//                .padding(.top,10)
                GradeCardView(pieChartEntries: viewModel.currentGradesEntries, grades: viewModel.currentGrades, proxy: p)
            }
        }
    }
}
