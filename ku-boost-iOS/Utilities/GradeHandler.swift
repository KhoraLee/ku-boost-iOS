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
    
    let realm = try! Realm()
    let Alamo = GradeService.shared.session
    
    func fetchGraduationSimulation(){
        Alamo.request(GradeRouter.GradeSimul).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let simulJson = try JSONDecoder().decode(GraduationSimulationResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for simul in simulJson.simulations {
                        let realmSimul = RealmSimulation()
                        realmSimul.setup(simul: simul)
                        try? weakSelf.realm.write {
                            weakSelf.realm.add(realmSimul, update: .modified)
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
    
    func fetchRegularGrade(year:Int, semester:Int){
        Alamo.request(GradeRouter.RegularGrade(year: year, semester: semester)).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let gradeJson = try JSONDecoder().decode(GradeResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for grade in gradeJson.grades{
                        
                        let realmGrade = RealmGrade()
                        realmGrade.setup(year: year, grade: grade)
                        try? weakSelf.realm.write {
                            weakSelf.realm.add(realmGrade, update: .modified)
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
                    let validJson = try JSONDecoder().decode(ValidGradeResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for validGrade in validJson.validGrades{
                        let grade = weakSelf.realm.objects(RealmGrade.self).filter("subjectId == '\(validGrade.subjectId)'").first!
                        try? weakSelf.realm.write {
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
