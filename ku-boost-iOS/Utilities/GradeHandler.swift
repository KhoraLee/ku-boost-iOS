//
//  GradeHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import Alamofire
import Combine

class GradeHandler {
    //학기 : 1 -> 1학기, 2 -> 2학기, 3 -> 여름 계절, 4 -> 겨울 계절
    
    static let shared = GradeHandler()
    
    var Alamo = GradeService.shared.session
    
    func fetchGraduationSimulation(){
        Alamo.request(GradeRouter.GradeSimul).responseJSON { (response) in
//            debugPrint(response)
        }
    }
    
    func fetchRegularGrade(year:Int, semester:Int){
        Alamo.request(GradeRouter.RegularGrade(year: year, semester: semester)).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let gradeJson = try JSONDecoder().decode(GradeResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    for grades in gradeJson.grades{
                        // TODO : DB에 데이터 삽입
                        print(grades) // 테스트 로깅
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
    
    func fetchValidGrades(year:Int, semester:Int, stdNo:Int){
        Alamo.request(GradeRouter.ValidGrade(year: year, semester: semester)).responseJSON { (response) in
//            debugPrint(response)
        }
    }
    
}
