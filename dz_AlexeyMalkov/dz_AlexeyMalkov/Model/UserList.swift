//
//  UserList.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift
//struct UserList{
//    var name: String
//    var avatar: UIImage
//    var userImage: [UIImage?]
//}
class UserList: Object, Decodable {
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var avatar = ""
    dynamic var id = 0
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
        case id
    }
}

class FriendResponse: Decodable {
    let items: [UserList]
}
class FriendResponseContainer: Decodable {
    let response: FriendResponse
}
