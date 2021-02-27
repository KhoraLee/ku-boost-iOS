//
//  SimulationCardView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/27.
//

import Charts
import SwiftUI

// MARK: - SimulationCardView

struct SimulationCardView: View {

  @ObservedObject var viewModel = SimulationViewModel.shared

  var proxy: GeometryProxy
  var title = ""

  var body: some View {

    VStack(alignment: .leading){
      HStack{
        VStack(alignment: .leading){
          if title != ""{
            Text("\(title)")
              .font(.title)
              .fontWeight(.black)
              .foregroundColor(.primary)
              .lineLimit(1)
          }
          List{
            HeaderRow()
            ForEach(viewModel.graduationSimulation, id: \.compoundKey ){ simul in
              SimulRow(simul: simul)
            }
          }
          .hasScrollEnabled(false)
          .listStyle(PlainListStyle())
          .environment(\.defaultMinListRowHeight, 40)
          .frame(height: 40 * CGFloat(viewModel.graduationSimulation.count + 1))
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
    .onAppear{
      viewModel.viewOnAppear()
    }

  }
}

// MARK: - HeaderRow

struct HeaderRow: View {

  var body: some View {
    GeometryReader{ proxy in
      HStack{
        VStack(alignment: .center){
          Text("이수구분")
            .bold()
        }.frame(width:proxy.size.width / 4.1)
        VStack(alignment: .center){
          Text("기준학점")
            .bold()
        }.frame(width:proxy.size.width / 4.1)
        VStack(alignment: .center){
          Text("취득학점")
            .bold()
        }.frame(width:proxy.size.width / 4.1)
        Spacer()
        VStack(alignment: .center){
          Text("잔여학점")
            .bold()
        }.frame(width:proxy.size.width / 4.1)
      }
    }
  }
}
