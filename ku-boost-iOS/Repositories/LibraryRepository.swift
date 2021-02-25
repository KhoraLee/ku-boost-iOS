//
//  LibraryRepository.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/25.
//

import PromiseKit

class LibraryRepository {
    
    static let shared = LibraryRepository()
    let api = LibraryService.shared.session
    
    func makeLoginRequest() -> Promise<Void> {
        return firstly{
            api.requestPromise(LibraryRouter.login)
        }.done{ (result: LibLoginResponse) in
            UserDefaults.authToken = result.data?.accessToken ?? ""
        }
    }
    
    func makeMobileQRCodeRequest() -> Promise<Void> {
        return firstly{
            api.requestPromise(LibraryRouter.getMobileQRCode)
        }.done{ (result: QRResponse) in
            UserDefaults.qrRaw = result.qrdata?.membershipCard ?? ""
        }
    }
    
}
