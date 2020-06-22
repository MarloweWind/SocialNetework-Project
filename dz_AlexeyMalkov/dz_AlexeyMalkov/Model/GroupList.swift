//
//  GroupList.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Foundation

//struct GroupList {
//    var groupName: String
//    var groupAvatar: UIImage?
//}
class GroupList: Decodable {
    dynamic var groupAvatar = ""
    dynamic var groupName = ""
    
    enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupAvatar = "photo_100"
    }
}

class CommunityResponse: Decodable {
    let items: [GroupList]
}
class CommunityResponseContainer: Decodable {
    let response: CommunityResponse
}
