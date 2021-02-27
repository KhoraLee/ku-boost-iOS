//
//  GradeRepository.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/21.
//

import Alamofire
import PromiseKit

class GradeRepository {

  static let shared = GradeRepository()

  let api = KuisService.shared.session
  let gradeDao = GradeDAO.shared
  let simulDao = GraduationSimulationDAO.shared
  let stdNo = UserDefaults.stdNo

  func makeGraduationSimulationRequest() -> Promise<Void> {
    firstly{
      api.requestPromise(GradeRouter.GradeSimul)
    }.done{ (result: GraduationSimulationResponse)  in
      let graduationSimulationResponse = result
      let simulations = graduationSimulationResponse.simulations
      var index = 0
      for simulation in simulations {
        let data = RealmSimulation()
        data.setup(simul: simulation, index: index)
        index += 1
        self.simulDao.insertGraduationSimulation(simul: data)
      }
    }
  }

  func makeAllGradesRequest() -> Promise<Void> {
    let semesterConverter = [1 : 1, 4 : 2, 2 : 3, 5 : 4]
    let startYear = Int(UserDefaults.stdNo.prefix(4)) ?? 2021
    let format = DateFormatter()
    format.dateFormat = "yyyy"
    let endYear = Int(format.string(from: Date())) ?? 2021
    let semesters = [5,2,4,1]

    return Promise { seal in
      for year in startYear...endYear {
        for semester in semesters {
          firstly{
            api.requestPromise(GradeRouter.RegularGrade(year: year, semester: semester))
          }.done{ (result: GradeResponse) in
            for grade in result.grades {
              let rGrade = RealmGrade()
              rGrade.setup(year: year, semester: semesterConverter[semester]!, grade: grade)
              self.gradeDao.insertGrade(grade: rGrade)
            }
            seal.fulfill(())
          }.catch{ err in
            seal.reject(err)
          }
        }
      }
      UserDefaults.hasData = true
    }

  }

  func makeAllValidGradesRequest() -> Promise<Void> {
    firstly{
      api.requestPromise(GradeRouter.ValidGrade)
    }.done{ (result: ValidGradeResponse) in
      for grade in result.validGrades{
        self.gradeDao.validateGrade(stdNo: self.stdNo, subjectId: grade.subjectId)
      }
    }
  }
//    func makeTotalRank() -> Promise<Void> {}

//    func makeSimulation() -> Promise<Void> {}

  func hasData() -> Bool { UserDefaults.hasData }

  func getGraduationSimulations() -> [RealmSimulation] {
    simulDao.loadGraduationSimulation(stdNo: stdNo)
  }

  func getAllValidGrades() -> [RealmGrade] {
    gradeDao.getAllGrades(stdNo: stdNo)
  }

  func getCurrentGrades() -> [RealmGrade] {
    gradeDao.getCurrentSemesterGrades(stdNo: stdNo)
  }

  func getGradesByClassification(clf: String) -> [RealmGrade] {
    gradeDao.getGradesByClassification(stdNo: stdNo, clf: clf)
  }

//    func getTotalRank(year: Int, semester: Int) -> Promise<RealmRank> {}

}
