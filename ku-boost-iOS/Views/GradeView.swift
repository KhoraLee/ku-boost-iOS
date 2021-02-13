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

    var body: some View {
        GeometryReader{ p in
            ScrollView {
                GradeCardView(proxy: p, title:"금학기성적")
                GradeCardView(proxy: p)
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            
        }
        
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView()
    }
}
