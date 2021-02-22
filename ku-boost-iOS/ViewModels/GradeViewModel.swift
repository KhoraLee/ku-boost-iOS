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
    let semesterConverter = [1 : 1, 2 : "하계 계절", 3 : 2, 4 : "동계 계절"] as [Int : Any]

    static let shared = GradeViewModel()

    let realm = try! Realm()
    let stdNo = UserDefaults.stdNo
    let gradeRepo = GradeRepository.shared
    private var disposables: Set<AnyCancellable> = []
    
    @Published var currentGrades: [RealmGrade] = []
    @Published var totalGrades: [RealmGrade] = []
    @Published var currentGradesEntries: [[PieChartDataEntry]] = []
    @Published var totalGradesEntries: [[PieChartDataEntry]] = []
    @Published var totalGradeLineEntries: [ChartDataEntry] = []
    
    @Published var currentSemester: String = ""
    @Published var semesters: [String] = []
    
    @Published var selectedSemester: String = ""
    
    init(){
        reload()
    }
    
    func reload() {
        fetchCurrentGradesFromLocalDb()
        fetchTotalGradesFromLocalDb()
        makeCurrentGradeEntries()
        makeTotalGradeEntries()
        makeGradeLineEntries()
    }
    
    func fetchCurrentGradesFromLocalDb() {
        currentGrades = gradeRepo.getCurrentGrades()
        currentSemester = "\(currentGrades[0].year)년도 \(semesterConverter[currentGrades[0].semester]!)학기"
    }
    
    func fetchTotalGradesFromLocalDb() {
        totalGrades = gradeRepo.getAllValidGrades()
        for grade in totalGrades {
            let sem = "\(grade.year)년도 \(semesterConverter[grade.semester]!)학기"
            if !semesters.contains(sem) {
                semesters.append(sem)
                selectedSemester = sem
            }
        }
    }
    
    func makeCurrentGradeEntries(){
        currentGradesEntries = [ChartUtils.makeSubjectEntry(grades: currentGrades),
                                ChartUtils.makeSubjectEntry(grades: currentGrades,isMajor: true),
                                ChartUtils.makeGradeEntry(grades: currentGrades)]
    }
    
    func makeTotalGradeEntries(){
        totalGradesEntries = [ChartUtils.makeSubjectEntry(grades: totalGrades),
                              ChartUtils.makeSubjectEntry(grades: totalGrades,isMajor: true),
                              ChartUtils.makeGradeEntry(grades: totalGrades)]
    }
    
    func makeGradeLineEntries(){
        totalGradeLineEntries = ChartUtils.makeGradeLineEntry(grades: totalGrades)
    }
    
    
    func getSelectedGradeEntries(semester: String) -> [[PieChartDataEntry]] {
        let tmpGrade = getSelectedGrades(semester: semester)
        
        return [ChartUtils.makeSubjectEntry(grades: tmpGrade),
                ChartUtils.makeSubjectEntry(grades: tmpGrade,isMajor: true),
                ChartUtils.makeGradeEntry(grades: tmpGrade)]
    }
    
    func getSelectedGrades(semester: String) -> [RealmGrade] {
        var tmpGrade = [RealmGrade]()
        for grade in totalGrades {
            let sem = "\(grade.year)년도 \(semesterConverter[grade.semester]!)학기"
            if sem == semester {
                tmpGrade.append(grade)
            }
        }
        return tmpGrade
    }
        
}

