//
//  SimulRow.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/27.
//

import SwiftUI

struct SimulRow: View {

  var simul: RealmSimulation
  @State var isTapped = false
  @State var gradeByCLF = [RealmGrade]()

  var body: some View {
    ZStack{
      GeometryReader { proxy in
        HStack{
          VStack(alignment: .center){
            Text(simul.classification)
              .font(.callout)
          }.frame(width:proxy.size.width / 4.1, height: proxy.size.height)
          VStack(alignment: .center){
            Text(String(simul.standard))
              .font(.callout)
          }.frame(width:proxy.size.width / 4.1)
          VStack(alignment: .center){
            Text(String(simul.acquired))
              .font(.callout)
          }.frame(width:proxy.size.width / 4.1)
          VStack(alignment: .center){
            Text(String(simul.remainder))
              .font(.callout)
          }.frame(width:proxy.size.width / 4.1)
        }.contentShape(Rectangle())
          .onTapGesture {
            gradeByCLF = GradeRepository.shared.getGradesByClassification(clf: simul.classification)
            if gradeByCLF.count != 0 { isTapped = true }
          }
      }
      NavigationLink(destination: Text(simul.classification),isActive:$isTapped){
        EmptyView()
      }.hidden()
    }
  }

}
