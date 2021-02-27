//
//  SimulationViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/27.
//

import Charts
import Combine
import PromiseKit
import RealmSwift
import SwiftUI

class SimulationViewModel: ObservableObject, Identifiable {

  // MARK: Internal

  static let shared = SimulationViewModel() // Singleton

  let gradeRepo = GradeRepository.shared
  var fetched = false // 서버로부터의 fetch 여부
  // MARK: - Data variables
  @Published var graduationSimulation = [RealmSimulation]()

  func isFetched() -> Bool { fetched }

  func hasData() -> Bool { gradeRepo.hasData() }

  func viewOnAppear() {
    fetchFromLocalDb()
    fetchFromServer()
  }

  func fetchFromLocalDb() {
    if isFetched() || !hasData() { return }
    fetchGraduationSimulationFromLocalDb()
  }

  func fetchFromServer() {
    if isFetched() { return }
    firstly{
      fetchGraduationSimulationFromServer()
    }.done{
      self.fetchFromLocalDb()
      self.fetched = true
    }.catch{ err in
      print(err)
    }
  }

  // MARK: - Fetch data from local DB

  func fetchGraduationSimulationFromLocalDb() {
    graduationSimulation = gradeRepo.getGraduationSimulations()
  }

  // MARK: - Fetch data from server

  func fetchGraduationSimulationFromServer() -> Promise<Void> {
    gradeRepo.makeGraduationSimulationRequest()
  }

  // MARK: - Variable things

  func makeChartEntriesByClf(clf: String) -> [[PieChartDataEntry]] {
    let grades = gradeRepo.getGradesByClassification(clf: clf)
    return [
      ChartUtils.makeSubjectEntry(grades: grades),
      ChartUtils.makeGradeEntry(grades: grades),
    ]
  }

  func getGradesByClf(clf: String) -> [RealmGrade] {
    gradeRepo.getGradesByClassification(clf: clf)
  }

  // MARK: Private

  private var disposables: Set<AnyCancellable> = []
}
