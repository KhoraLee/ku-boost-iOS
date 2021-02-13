//
//  GradeViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/12.
//

import SwiftUI
import Combine
import RealmSwift

class GradeViewModel: ObservableObject, Identifiable {

    let realm = try! Realm()
    let stdNo = UserDefaults.standard.string(forKey: "stdNo") ?? ""
    private var disposables: Set<AnyCancellable> = []
    
    @Published var curSemGrades: [RealmGrade] = []
    @Published var curSem = ""
    
    init(){
        fetchCurrentGradesFromLocalDb()
    }
    
    func fetchCurrentGradesFromLocalDb() {
        let curSemGrade = realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)'")
            .sorted(by: [SortDescriptor(keyPath: "year",ascending: false),SortDescriptor(keyPath: "semester",ascending: false)]).first
        curSem = "\(curSemGrade?.year) \(curSemGrade?.semester)"
        let curGrades = realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && year == \(curSemGrade?.year ?? 2000) && semester == '\(curSemGrade?.semester ?? "")'").toArray(ofType: RealmGrade.self)
        for grade in curGrades {
            curSemGrades.append(grade)
        }
        print("fetchCurrentGradesFromLocalDb() Done")
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
