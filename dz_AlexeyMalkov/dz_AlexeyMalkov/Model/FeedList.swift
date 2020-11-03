//
//  FeedList.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SwiftyJSON

class FeedSource: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class FeedList{
    var postId: String = ""
    var feedPhoto: Photo
    var text: String = ""
    var likes: String = ""
    var comments: String = ""
    var reposts: String = ""
    
    init(json: JSON) {
        self.postId = json["source_id"].stringValue
        self.text = json["text"].stringValue
        self.likes = json["likes"]["count"].stringValue
        self.comments = json["comments"]["count"].stringValue
        self.reposts = json["reposts"]["count"].stringValue
        self.feedPhoto = Photo.init(json: json["attachments"].arrayValue)
    }
}
