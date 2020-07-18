//
//  UserSession.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import Foundation

class UserSession{
    
    static let instance = UserSession()
    static let shared: UserSession = .init()
    
    private init() {}
    
    var token = ""
    var userId = 0
    
}
