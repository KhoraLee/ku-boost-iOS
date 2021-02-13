//
//  DebugView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import SwiftUI
import Combine
import Alamofire
import RealmSwift

struct DebugView: View {
    
    let realm = try! Realm()

    @State var text = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Logon Successfully").padding()
            Text("\(UserDefaults.standard.string(forKey: "name")!)(\(UserDefaults.standard.string(forKey: "stdNo")!))님 반갑습니다")
            HStack{
                Button(action: {
                    makeAllGradeRequest()
                }, label: {
                    Text("Fetch Grade")
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                Button(action: {
                    makeSimulRequest()
                }, label: {
                    Text("Fetch Simul")
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                Button(action: {
                    validateGradeRequest()
                }, label: {
                    Text("Validate Grade")
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(10)
                })
            }
            HStack{
                    TextField("검색할 성적을 입력하세요", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding(.horizontal)
                HStack{Button(action: {
                    let GradeAplus = realm.objects(RealmGrade.self).filter("characterGrade='\(text.uppercased())'")
                    for grade in GradeAplus {
                        print(grade.subjectName + " \(grade.grade.value ?? -1)")
                    }
                    print()
                }, label: {
                    Text("Parse DB")
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                Button(action: {
                    print(realm.configuration.fileURL!)
                }, label: {
                    Text("DB File Path")
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                Button(action: {
                    try! realm.write {
                      realm.deleteAll()
                    }
                }, label: {
                    Text("Reset DB")
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(10)
                })
            }
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
        let gh = GradeHandler.shared
        let startY = 2018
        let endY = 2020
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

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
