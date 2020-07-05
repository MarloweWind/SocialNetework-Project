//
//  GroupList.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SwiftyJSON

//struct GroupList {
//    var groupName: String
//    var groupAvatar: UIImage?
//}
class GroupListRealm: Object {
    @objc dynamic var groupId: Int = 0
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupAvatar: String = ""
   
    override class func primaryKey() -> String? {
        return "groupId"
    }
}

struct GroupList: Equatable {
    
    let groupId: Int
    var groupName: String = ""
    var groupAvatar: String = ""
    
    init(id: Int) {
        self.groupId = id
    }
    
    init(json: JSON) {
        let id = json["id"].intValue
        self.init(id: id)
        self.groupName = json["name"].stringValue
        self.groupAvatar = json["photo_50"].stringValue
    }
}
