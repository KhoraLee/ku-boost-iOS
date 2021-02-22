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
    
    @State var selectedSemester = ""
    
    var body: some View {
        GeometryReader{ p in
            VStack {
                ZStack{
                    Menu("\(selectedSemester == "" ? viewModel.currentSemester : selectedSemester)"){
                        ForEach(viewModel.semesters, id: \.self) { sem in
                            Button("\(sem)", action: {
                                selectedSemester = sem
                            })
                        }
                    }.frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                GradeCardView(pieChartEntries: viewModel.getSelectedGradeEntries(semester: selectedSemester == "" ? viewModel.currentSemester : selectedSemester), grades: viewModel.getSelectedGrades(semester: selectedSemester == "" ? viewModel.currentSemester : selectedSemester), proxy: p)
            }
        }.navigationBarHidden(true)

    }
    
}
