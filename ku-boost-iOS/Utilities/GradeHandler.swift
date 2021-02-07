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
    var Alamo = GradeService.shared.session
    
    func fetchGraduationSimulation(){
        Alamo.request(GradeRouter.GradeSimul).responseJSON { (response) in
//            debugPrint(response)
        }
    }
    
    func fetchRegularGrade(year:Int, semester:Int){
        Alamo.request(GradeRouter.RegularGrade(year: year, semester: semester)).responseJSON { (response) in
//            debugPrint(response)
        }
    }
    
    func fetchValidGrades(year:Int, semester:Int, stdNo:Int){
        Alamo.request(GradeRouter.ValidGrade(year: year, semester: semester)).responseJSON { (response) in
//            debugPrint(response)
        }
    }
    
}
