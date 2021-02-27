//
//  SimulationDetailView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/27.
//

import Charts
import SwiftUI

struct SimulationDetailView: View {

  var simul: RealmSimulation

  @ObservedObject var viewModel = SimulationViewModel.shared

  var body: some View {
    GeometryReader{ proxy in
      ScrollView{

        HStack{
          BackBtn()
            .padding(.top,15)
            .padding(.leading,20)
          Text(simul.classification)
            .font(.title)
            .fontWeight(.bold)
            .padding([.top,.leading])
          Spacer()
        }
        VStack(alignment: .leading){
          HStack{
            VStack(alignment: .leading){
              // Card view starts here
              HStack{
                let chartEntries = viewModel.makeChartEntriesByClf(clf: simul.classification)
                PieChart(
                  classification: "전체",
                  average: chartEntries[0][0].value,
                  isSummury: true,
                  entries: chartEntries[0])
                  .frame(height: proxy.size.width * 0.8 / 3)
                Spacer()
                PieChart(entries: chartEntries[1])
                  .frame(height: proxy.size.width * 0.8 / 3)
              }
              List{
                ForEach(viewModel.getGradesByClf(clf: simul.classification), id: \.compoundKey)
                  { grade in
                    GradeRow(grade: grade)
                  }
              }
              .hasScrollEnabled(false)
              .listStyle(PlainListStyle())
              .environment(\.defaultMinListRowHeight, 40)
              .frame(
                height: 40 * CGFloat(viewModel.getGradesByClf(clf: simul.classification).count))
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
      }
      .navigationBarHidden(true)
    }
  }
}
