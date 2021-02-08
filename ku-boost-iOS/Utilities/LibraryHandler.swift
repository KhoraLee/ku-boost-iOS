//
//  LibraryHandler.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Alamofire
import Combine
import RealmSwift

class LibraryHandler {
    
    static let shared = LibraryHandler()
    
    let Alamo = LibraryService.shared.session
    
    func login(id:String, pw:String){
        Alamo.request(LibraryRouter.login(id: id, pw: pw)).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let loginJson = try JSONDecoder().decode(LibLoginResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    guard let token = loginJson.data?.accessToken else { return }
                    UserDefaults.standard.setValue(token, forKey: "pyxis-auth-token")
                    print(token)
                    LibraryHandler.shared.getMobileQRCode()
                } catch(let error){
                    debugPrint(error)
                }
            case .failure(let err):
                debugPrint(err)
            }
            return
        }
    }
    
    func getMobileQRCode(){
        Alamo.request(LibraryRouter.getMobileQRCode).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success(let data):
                do{
                    let qrJson = try JSONDecoder().decode(QRResponse.self, from: JSONSerialization.data(withJSONObject: data))
                    print(qrJson.qrdata?.membershipCard ?? "")
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
