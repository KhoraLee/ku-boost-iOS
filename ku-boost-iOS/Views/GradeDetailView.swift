//
//  GradeDetailView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import SwiftUI

struct GradeDetailView: View {

  var grade: RealmGrade

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  @State var textHeight: CGFloat = 0
  @State var textWidth: CGFloat = 0

  let semesterConverter = [1 : "1", 2 : "하계 계절", 3 : "2", 4 : "동계 계절"]

  var body: some View {
    VStack{
      HStack{
        BackBtn()
          .padding(.top,15)
          .padding(.leading,20)
        Spacer()
      }
      HStack{
        VStack(alignment: .leading, spacing: 5){
          Text("\(grade.subjectName)")
            .bold()
            .font(.title2)
          Text("\(String(grade.year))년도 \(semesterConverter[grade.semester]!)학기")
        }.padding()
          .padding(.leading,5)
          .background(
            GeometryReader { proxy in
              Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
            }
          )
          .onPreferenceChange(SizePreferenceKey.self){ preferences in
            self.textHeight = preferences.height
          }
        Spacer()
        Text("\(grade.characterGrade)")
          .font(.title3)
          .bold()
          .frame(width: textHeight * 0.7, height: textHeight * 0.7)
          .background(Color("secondaryLightColor"))
          .cornerRadius(90)
          .padding()
          .padding(.trailing,10)
      } // 상단 뷰

      VStack(alignment: .leading){
        HStack{
          VStack(alignment: .leading){
            // Content start
            VStack(spacing:15){
              HStack{
                Text("학수번호")
                  .bold()
                  .padding(.trailing,textWidth * 1 / 3)
                  .padding(.trailing)

                Text("\(grade.subjectNumber)")
                Spacer()
              }
              HStack{
                Text("과목번호")
                  .bold()
                  .padding(.trailing,textWidth * 1 / 3)
                  .padding(.trailing)
                Text("\(grade.subjectId)")
                Spacer()
              }
              HStack{
                Text("담당교수")
                  .bold()
                  .padding(.trailing,textWidth * 1 / 3)
                  .padding(.trailing)
                Text("\(grade.professor)")
                Spacer()
              }
              HStack{
                Text("이수구분")
                  .bold()
                  .padding(.trailing,textWidth * 1 / 3)
                  .padding(.trailing)
                Text("\(grade.classification)")
                Spacer()
              }
              HStack{
                Text("학점")
                  .bold()
                  .padding(.trailing,textWidth * 2 / 3)
                  .padding(.trailing)
                Text("\(grade.subjectPoint.value ?? 0)")
                Spacer()
              }
              HStack{
                Text("성적평가방식")
                  .bold()
                  .background(
                    GeometryReader { proxy in
                      Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                  )
                  .onPreferenceChange(SizePreferenceKey.self){ preferences in
                    self.textWidth = preferences.width
                  }
                  .padding(.trailing)
                Text("\(grade.evaluationMethod)")
                Spacer()
              }
            }
            // Content end

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
      .padding([ .horizontal]) // 카드 뷰

    }.navigationBarHidden(true)
    Spacer()

  }

}
