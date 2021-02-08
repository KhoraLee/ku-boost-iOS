//
//  GradeHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Alamofire
import Combine
import RealmSwift

class GradeHandler {
    //학기 : 1 -> 1학기, 2 -> 2학기, 3 -> 여름 계절, 4 -> 겨울 계절
    
    static let shared = GradeHandler()
    
    var Alamo = GradeService.shared.session
    
    func fetchGraduationSimulation(){
        Alamo.request(GradeRouter.GradeSimul).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let simulJson = try JSONDecoder().decode(GraduationSimulationResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for simul in simulJson.simulations {
                        // TODO : DB에 데이터 삽입
                        print(simul) // 테스트 로깅
                    }
                } catch(let error){
                    debugPrint(error)
                }
            case .failure(let err):
                debugPrint(err)
            }
            return
        }
    }
    
    func fetchRegularGrade(year:Int, semester:Int){
        Alamo.request(GradeRouter.RegularGrade(year: year, semester: semester)).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let realm = try! Realm()
                    let gradeJson = try JSONDecoder().decode(GradeResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for grade in gradeJson.grades{
                        
                        let realmGrade = RealmGrade()
                        realmGrade.setup(year: year, grade: grade)
                        try? realm.write {
                            realm.add(realmGrade, update: .modified)
                        }
                    }
                } catch(let error){
                    debugPrint(error)
                }
            case .failure(let err):
                debugPrint(err)
            }
            return
        }
    }
    
    func fetchValidGrades(){
        Alamo.request(GradeRouter.ValidGrade).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let realm = try! Realm()

                    let validJson = try JSONDecoder().decode(ValidGradeResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for validGrade in validJson.validGrades{
                        let grade = realm.objects(RealmGrade.self).filter("subjectId == '\(validGrade.subjectId)'").first!
                        try? realm.write {
                            grade.validate()
                        }
                    }
                } catch(let error){
                    debugPrint(error)
                }
            case .failure(let err):
                debugPrint(err)
            }
            return
        }
    }
    
}
