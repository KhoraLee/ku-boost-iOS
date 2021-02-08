//
//  MainView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import SwiftUI
import Combine
import Alamofire
import RealmSwift

struct MainView: View {
    
    let realm = try! Realm()

    @State var text = "a+"
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Logon Successfully").padding()
            Button(action: {
                makeAllGradeRequest()
            }, label: {
                Text("Fetch Grade")
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(10)
            }).padding()
            Button(action: {
                makeSimulRequest()
            }, label: {
                Text("Fetch Simul")
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(10)
            }).padding()
            Button(action: {
                validateGradeRequest()
            }, label: {
                Text("Validate Grade")
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(10)
            }).padding()
            HStack{
                TextField("검색할 성적", text: $text)
                    .font(.largeTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.horizontal)
            Button(action: {
                let GradeAplus = realm.objects(RealmGrade.self).filter("characterGrade='\(text.uppercased())'")
                for grade in GradeAplus {
                    print(grade.subjectName + " \(grade.grade.value)")
                }
                print()
            }, label: {
                Text("Parse DB")
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(10)
            })

            Button(action: {
                let ah = LibraryHandler.shared
                let username = UserDefaults.standard.string(forKey: "id")!
                let password = UserDefaults.standard.string(forKey: "pw")!
                ah.login(id: username, pw: password)
            }, label: {
                Text("GET Lib QR Raw")
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(10)
            }).padding()
        }
    }
    
    private func makeAllGradeRequest(){
        print(realm.configuration.fileURL!)

        let gh = GradeHandler.shared
        let startY = 2018
        let endY = 2021
        let semester = [1,4,2,5]
        for year in startY...endY {
            for sem in semester {
                gh.fetchRegularGrade(year: year, semester: sem)
            }
        }
    }
    
    private func validateGradeRequest(){
        let gh = GradeHandler.shared
        gh.fetchValidGrades()
    }
    
    private func makeSimulRequest(){
        let gh = GradeHandler.shared
        gh.fetchGraduationSimulation()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
