//
//  UserNameFactory.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 09.09.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import Foundation

class UserNameFactory{
    
    func userName(object: Friend) -> String{
//        object.firstName + " " + object.lastName
        return object.firstName + " " + object.lastName
    }
    
}
