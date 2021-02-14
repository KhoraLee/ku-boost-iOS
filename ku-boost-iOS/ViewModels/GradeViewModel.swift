//
//  GradeViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/12.
//

import SwiftUI
import Combine
import RealmSwift
import Charts

class GradeViewModel: ObservableObject, Identifiable {
    
    static let shared = GradeViewModel()

    let realm = try! Realm()
    let stdNo = UserDefaults.standard.string(forKey: "stdNo") ?? ""
    private var disposables: Set<AnyCancellable> = []
    
    @Published var currentGrades: [RealmGrade] = []
    @Published var totalGrades: [RealmGrade] = []
    @Published var currentGradesEntries: [[PieChartDataEntry]] = []
    @Published var totalGradesEntries: [[PieChartDataEntry]] = []
    @Published var totalGradeLineEntries: [ChartDataEntry] = []
    
    init(){
        reload()
    }
    
    func reload() {
        fetchCurrentGradesFromLocalDb()
        fetchTotalGradesFromLocalDb()
        makeCurrentGradeEntries()
        makeTotalGradeEntries()
        makeGradeLineEntry()
    }
    
    func fetchCurrentGradesFromLocalDb() {
        let curSemGrade = realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)'")
            .sorted(by: [SortDescriptor(keyPath: "year",ascending: false),SortDescriptor(keyPath: "semester",ascending: false)]).first
        let curGrades = realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && year == \(curSemGrade?.year ?? 2000) && semester == '\(curSemGrade?.semester ?? "")'").toArray(ofType: RealmGrade.self)
        for grade in curGrades {
            currentGrades.append(grade)
        }
        print("fetchCurrentGradesFromLocalDb() Done")
    }
    
    func fetchTotalGradesFromLocalDb() {
        let totGrades = realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && valid == true").toArray(ofType: RealmGrade.self)
        for grade in totGrades {
            totalGrades.append(grade)
        }
        print("fetchTotalGradesFromLocalDb() Done")
    }
    
    func makeCurrentGradeEntries(){
       currentGradesEntries = [makeSubjectEntry(grades: currentGrades),
                               makeSubjectEntry(grades: currentGrades,isMajor: true),
                               makeGradeEntry(grades: currentGrades)]
    }
    
    func makeTotalGradeEntries(){
      totalGradesEntries = [makeSubjectEntry(grades: totalGrades),
                               makeSubjectEntry(grades: totalGrades,isMajor: true),
                               makeGradeEntry(grades: totalGrades)]
    }
    
    func makeGradeEntry(grades:[RealmGrade]) -> [PieChartDataEntry] {
        var tmp = [String:Int]()
        var result = [PieChartDataEntry]()
        
        for grade in grades {
            let key = grade.characterGrade
            if (tmp[key] == nil){ tmp[key] = 0 }
            tmp[key] = tmp[key]! + 1
        }
        
        let sorted = tmp.sorted {
            if $0.value == $1.value{
                return $0.key.prefix(1) < $1.key.prefix(1)
            } else {
                return $0.value > $1.value
            }
        }
        sorted.forEach{ key,value in
            result.append(PieChartDataEntry(value: Double(value), label:key))
        }
        return result
    }
    
    func makeSubjectEntry(grades: [RealmGrade], isMajor: Bool = false) -> [PieChartDataEntry] {
        var sum: Float = 0
        var count: Float = 0
        for grade in grades {
            if isMajor {
                if grade.classification == "전필" || grade.classification == "전선" {
                    sum += (grade.grade.value ?? 0) * Float(grade.subjectPoint.value ?? 0)
                    count += Float(grade.subjectPoint.value ?? 0)
                }
            } else {
                if grade.evaluationMethod == "P/N평가" { continue }
                sum += (grade.grade.value ?? 0) * Float(grade.subjectPoint.value ?? 0)
                count += Float(grade.subjectPoint.value ?? 0)
            }
        }
        if sum == 0 && count == 0 {
            return[PieChartDataEntry(value: 0, label:"grade"),
                   PieChartDataEntry(value: 4.5, label:"total")]
        }
        return[PieChartDataEntry(value: Double(sum/count), label:"grade"),
               PieChartDataEntry(value: 4.5 - Double(sum/count), label:"total")]
    }
    
    func makeGradeLineEntry() {
        var sum = [String:Float]()
        var count = [String:Float]()

        for grade in totalGrades {
            if grade.evaluationMethod == "P/N평가" { continue }
            let key = "\(grade.year)\(grade.semester.prefix(1))"
            if sum[key] == nil {
                sum[key] = 0
                count[key] = 0
            }
            sum[key]! += (grade.grade.value ?? 0) * Float(grade.subjectPoint.value ?? 0)
            count[key]! += Float(grade.subjectPoint.value ?? 0)
        }
        
        let sorted = sum.sorted { $0.key < $1.key }
        
        for (key,value) in sorted {
            let avg = value / count[key]!
            if value == 0 && count[key] == 0 { continue }
            totalGradeLineEntries.append(ChartDataEntry(x: Double(key) ?? 0, y: Double(floor(Float(avg)*100)/100)))
        }
        
        
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
