//
//  PreferenceManager.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/21.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {

    @UserDefault(key:"cookie", defaultValue:"")
    static var cookie: String
    
    @UserDefault(key:"name", defaultValue:"")
    static var name: String
    
    @UserDefault(key:"stdNo", defaultValue:"")
    static var stdNo: String
    
    @UserDefault(key:"state", defaultValue:"")
    static var state: String
    
    @UserDefault(key:"dept", defaultValue:"")
    static var dept: String
    
    @UserDefault(key:"code", defaultValue:"")
    static var code: String
    
    @UserDefault(key:"hasData", defaultValue:false)
    static var hasData: Bool
    
    @UserDefault(key:"accessToken", defaultValue:"")
    static var accessToken: String
    
    @UserDefault(key:"selectedSemester", defaultValue:1)
    static var selectedSemester: Int
    
}
