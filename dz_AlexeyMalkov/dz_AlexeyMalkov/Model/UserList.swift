//
//  UserList.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class UserListRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

struct Friend {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    var bdate: String = ""
    var usersPhoto: String = ""
}
