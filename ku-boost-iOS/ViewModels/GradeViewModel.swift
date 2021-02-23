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
import PromiseKit

class GradeViewModel: ObservableObject, Identifiable {
    
    static let shared = GradeViewModel() // Singleton

    let gradeRepo = GradeRepository.shared
    var fetched = false // 서버로부터의 fetch 여부
    let semesterConverter = [1 : 1, 2 : "하계 계절", 3 : 2, 4 : "동계 계절"] as [Int : Any]
    private var disposables: Set<AnyCancellable> = []
    // MARK: - Data variables
    @Published var currentGrades = [RealmGrade]()
    @Published var allValidGrades = [RealmGrade]()
    @Published var graduationSimulation = [RealmSimulation]()
    @Published var ranks = [RealmRank]()
    // MARK: - Chart entries variables
    @Published var currentGradesEntries = [[PieChartDataEntry]]()
    @Published var totalGradesEntries = [[PieChartDataEntry]]()
    @Published var totalGradeLineEntries = [ChartDataEntry]()
    //MARK: - Semester variables
    @Published var semesters = [String]()
    @Published var currentSemester: String = ""
    @Published var selectedSemester: String = ""
    
    //MARK: -
    init() {
        makeChartEntries() // make empty chart entries for first view draw
    }
    
    func isFetched() -> Bool { fetched }

    func hasData() -> Bool { gradeRepo.hasData() }
    
    func viewOnAppear() {
        fetchFromLocalDb()
        fetchFromServer()
    }
    
    
    func fetchFromLocalDb() {
        if (isFetched() || !hasData()) { return }
        fetchCurrentGradesFromLocalDb()
        fetchAllGradesFromLocalDb()
        fetchGraduationSimulationFromLocalDb()
        fetchAllRankFromLocalDb()
        makeChartEntries()
    }
    
    func fetchFromServer() {
        if isFetched() { return }
        when(fulfilled :[
                fetchGraduationSimulationFromServer(),
                fetchAllGradesFromServer(),
                fetchRankFromServer()
        ])
        .done{
            self.fetchFromLocalDb()
            self.makeChartEntries()
            self.fetched = true
        }.catch{ err in
            print("err")
        }
    }
    
    func makeChartEntries() {
        makeCurrentGradeEntries()
        makeTotalGradeEntries()
        makeGradeLineEntries()
    }
    
    // MARK: - Fetch data from local DB
    func fetchCurrentGradesFromLocalDb() {
        currentGrades = gradeRepo.getCurrentGrades()
        currentSemester = "\(currentGrades[0].year)년도 \(semesterConverter[currentGrades[0].semester]!)학기"
    }
    
    func fetchAllGradesFromLocalDb() {
        allValidGrades = gradeRepo.getAllValidGrades()
        for grade in allValidGrades {
            let sem = "\(grade.year)년도 \(semesterConverter[grade.semester]!)학기"
            if !semesters.contains(sem) {
                semesters.append(sem)
                selectedSemester = sem
            }
        }
    }
    
    func fetchGraduationSimulationFromLocalDb() {}
    
    func fetchAllRankFromLocalDb() {}
    
    // MARK: - Fetch data from server
    func fetchGraduationSimulationFromServer() -> Promise<Void> {
        return gradeRepo.makeGraduationSimulationRequest()
    }
    
    func fetchAllGradesFromServer() -> Promise<Void>  {
        return firstly{
            gradeRepo.makeAllGradesRequest()
        }.then{
            self.gradeRepo.makeAllValidGradesRequest()
        }
    }
    
    // TODO: Rank 구현
    func fetchRankFromServer() -> Promise<Void>  {
        return Promise()
    }
    
    // MARK: - Make chart entries
    func makeCurrentGradeEntries(){
        currentGradesEntries = [ChartUtils.makeSubjectEntry(grades: currentGrades),
                                ChartUtils.makeSubjectEntry(grades: currentGrades,isMajor: true),
                                ChartUtils.makeGradeEntry(grades: currentGrades)]
    }
    
    func makeTotalGradeEntries(){
        totalGradesEntries = [ChartUtils.makeSubjectEntry(grades: allValidGrades),
                              ChartUtils.makeSubjectEntry(grades: allValidGrades,isMajor: true),
                              ChartUtils.makeGradeEntry(grades: allValidGrades)]
    }
    
    func makeGradeLineEntries(){
        totalGradeLineEntries = ChartUtils.makeGradeLineEntry(grades: allValidGrades)
    }
    
    // MARK: - Functions for TotalGradeDetailView
    func makeSelectedGradeEntries(semester: String) -> [[PieChartDataEntry]] {
        let tmpGrade = getSelectedGrades(semester: semester)
        
        return [ChartUtils.makeSubjectEntry(grades: tmpGrade),
                ChartUtils.makeSubjectEntry(grades: tmpGrade,isMajor: true),
                ChartUtils.makeGradeEntry(grades: tmpGrade)]
    }
    
    func getSelectedGrades(semester: String) -> [RealmGrade] {
        var tmpGrade = [RealmGrade]()
        for grade in allValidGrades {
            let sem = "\(grade.year)년도 \(semesterConverter[grade.semester]!)학기"
            if sem == semester {
                tmpGrade.append(grade)
            }
        }
        return tmpGrade
    }
        
}

