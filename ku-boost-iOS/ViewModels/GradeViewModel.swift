//
//  GradeViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/12.
//

import Charts
import Combine
import PromiseKit
import RealmSwift
import SwiftUI

class GradeViewModel: ObservableObject, Identifiable {

  // MARK: Lifecycle

  //MARK: -
  init() {
    makeChartEntries() // make empty chart entries for first view draw
  }

  // MARK: Internal

  static let shared = GradeViewModel() // Singleton

  let gradeRepo = GradeRepository.shared
  var fetched = false // 서버로부터의 fetch 여부
  let semesterConverter = [1 : "1", 2 : "하계 계절", 3 : "2", 4 : "동계 계절"]
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

  func isFetched() -> Bool { fetched }

  func hasData() -> Bool { gradeRepo.hasData() }

  func viewOnAppear() {
    fetchFromLocalDb()
    fetchFromServer()
  }

  func fetchFromLocalDb() {
    if isFetched() || !hasData() { return }
    fetchCurrentGradesFromLocalDb()
    fetchAllGradesFromLocalDb()
    fetchGraduationSimulationFromLocalDb()
    fetchAllRankFromLocalDb()
    makeSemesterList()
    makeChartEntries()
  }

  func fetchFromServer() {
    if isFetched() { return }
    when(fulfilled :[
      fetchGraduationSimulationFromServer(),
      fetchAllGradesFromServer(),
      fetchRankFromServer(),
    ])
      .done{
        self.fetchFromLocalDb()
        self.makeChartEntries()
        self.fetched = true
      }.catch{ err in
        print(err)
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
    let grade = currentGrades[0]
    currentSemester = "\(grade.year)년도 \(semesterConverter[grade.semester]!)학기"
  }

  func fetchAllGradesFromLocalDb() {
    allValidGrades = gradeRepo.getAllValidGrades()
  }

  func fetchGraduationSimulationFromLocalDb() {}

  func fetchAllRankFromLocalDb() {}

  // MARK: - Fetch data from server
  func fetchGraduationSimulationFromServer() -> Promise<Void> {
    gradeRepo.makeGraduationSimulationRequest()
  }

  func fetchAllGradesFromServer() -> Promise<Void>  {
    firstly{
      gradeRepo.makeAllGradesRequest()
    }.then{
      self.gradeRepo.makeAllValidGradesRequest()
    }
  }

  // TODO: Rank 구현
  func fetchRankFromServer() -> Promise<Void>  {
    Promise()
  }

  // MARK: - Make chart entries
  func makeCurrentGradeEntries(){
    currentGradesEntries = [
      ChartUtils.makeSubjectEntry(grades: currentGrades),
      ChartUtils.makeSubjectEntry(grades: currentGrades,isMajor: true),
      ChartUtils.makeGradeEntry(grades: currentGrades),
    ]
  }

  func makeTotalGradeEntries(){
    totalGradesEntries = [
      ChartUtils.makeSubjectEntry(grades: allValidGrades),
      ChartUtils.makeSubjectEntry(grades: allValidGrades,isMajor: true),
      ChartUtils.makeGradeEntry(grades: allValidGrades),
    ]
  }

  func makeGradeLineEntries(){
    totalGradeLineEntries = ChartUtils.makeGradeLineEntry(grades: allValidGrades)
  }

  // MARK: - Others

  func makeSemesterList(){
    for grade in allValidGrades {
      let sem = "\(grade.year)년도 \(semesterConverter[grade.semester]!)학기"
      if !semesters.contains(sem) {
        semesters.append(sem)
        selectedSemester = sem
      }
    }
//        semesters.sort()
  }

  func makeSelectedGradeEntries(semester: String) -> [[PieChartDataEntry]] {
    let tmpGrade = getSelectedGrades(semester: semester)

    return [
      ChartUtils.makeSubjectEntry(grades: tmpGrade),
      ChartUtils.makeSubjectEntry(grades: tmpGrade,isMajor: true),
      ChartUtils.makeGradeEntry(grades: tmpGrade),
    ]
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

  // MARK: Private

  private var disposables: Set<AnyCancellable> = []
}
