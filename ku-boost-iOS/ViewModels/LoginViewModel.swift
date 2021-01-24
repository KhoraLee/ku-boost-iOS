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
    
    @Published var cookie = ""
    
    @Published var shouldNavigate = false
    
    private var disposables: Set<AnyCancellable> = []
    
    var loginHandler = LoginHandler()
    
  
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$isLogon
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private var cookiePublisher: AnyPublisher<String, Never> {
     
        loginHandler.$cookie
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
        
        cookiePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.cookie, on: self)
            .store(in: &disposables)
        var isAutoLogin = UserDefaults.standard.bool(forKey: "autologin")
        
        if isAutoLogin {
            username = UserDefaults.standard.string(forKey: "id")!
            password = UserDefaults.standard.string(forKey: "pw")!
        }
        
    }
    
    func doLogin(){
        loginHandler.doLogin(id:username, passwd:password)
        
        var ud = UserDefaults.standard
        ud.set(username, forKey: "id")
        ud.set(password,forKey: "pw")
        ud.set(true, forKey: "autologin")
    }
    
}
