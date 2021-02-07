//
//  LoginViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/01/17.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject, Identifiable {
    
    @Published var username = ""
    @Published var password = ""
    
    @Published var isLogon = false
    @Published var isLoading = false
      
    @Published var shouldNavigate = false
    
    private var disposables: Set<AnyCancellable> = []
    
    var authHandler = AuthHandler.shared
    
  
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        authHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        authHandler.$isLogon
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        
        isAuthenticatedPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLogon, on: self)
            .store(in: &disposables)
        
        let isAutoLogin = UserDefaults.standard.bool(forKey: "autologin")
        
        if isAutoLogin {
            username = UserDefaults.standard.string(forKey: "id")!
            password = UserDefaults.standard.string(forKey: "pw")!
            doLogin()
        }
        
    }
    
    func doLogin(){
        authHandler.login(id:username, passwd:password)
    }
    
}
