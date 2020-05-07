//
//  Defaults.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
    static let userKey = "Key"
    static let userDefault = UserDefaults.standard
    static let user = User( )
    private static let sharedInstance = UserDefaultsManager.init()
    static func shared ( ) -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
   }
    
func saveDataFor(user: User){
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(user) else {return}
        UserDefaultsManager.userDefault.set(encoded, forKey: UserDefaultsManager.userKey)
    }
    
    func getSavedData()-> User {
        let decoder = JSONDecoder()
        guard let savedUser = UserDefaultsManager.userDefault.object(forKey: UserDefaultsManager.userKey) as? Data else {return UserDefaultsManager.user}
        guard let storedData = try? decoder.decode(User.self, from: savedUser) else {return UserDefaultsManager.user}
        //    print(storedData.email!)
        return storedData
    }
    
    func clearUserSavedData(){
        UserDefaultsManager.userDefault.removeObject(forKey: UserDefaultsManager.userKey)
    }
}

