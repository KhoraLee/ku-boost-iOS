//
//  SettingViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import SwiftUI
import Combine
import PromiseKit

class SettingViewModel: ObservableObject, Identifiable {
    
    static let shared = SettingViewModel()
    
    let authRepo = AuthRepository.shared
    
    @Published var profileImage:Data? = nil
    private var disposables: Set<AnyCancellable> = []

    func getProfileImage() {
        firstly{
            authRepo.makeStudentInformationRequest()
        }.done{
            let encoded = UserDefaults.standard.string(forKey: "photo") ?? ""
            self.profileImage = Data(base64Encoded: encoded)
        }.catch{ err in
            print(err)
        }
    }
}
