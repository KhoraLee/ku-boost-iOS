//
//  MainView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//


import SwiftUI
import Combine

struct MainView: View {
    
        var body: some View {
            TabView{
                GradeView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("성적")
                    }
                    .navigationBarHidden(true)
                DebugView()
                    .tabItem {
                        Image(systemName: "ladybug.fill")
                        Text("디버그")
                        
                    }
            }
        }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
