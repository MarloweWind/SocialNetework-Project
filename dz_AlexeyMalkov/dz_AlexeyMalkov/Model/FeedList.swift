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

struct FeedListFireBase{
    var headLine: String
    var imageFeed: String
    var feed: String
    var usersAvatar: String
    var usersName: String
    var commentsCount: String
    var repostCount: String
    var viewsCount: String
}

class FeedListVK: Object {
    @objc dynamic var postId: Int = 0
    @objc dynamic var sourceId: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var views: Int = 0
    @objc dynamic var likes: Int = 0
    @objc dynamic var comments: Int = 0
    @objc dynamic var reposts: Int = 0
    
    override class func primaryKey() -> String? {
        return "postId"
    }
}

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
    var text: String = ""
    var views: String = ""
    var likes: String = ""
    var comments: String = ""
    var reposts: String = ""
    
    init(json: JSON) {
        self.postId = json["source_id"].stringValue
        self.text = json["text"].stringValue
        self.views = json["views"]["count"].stringValue
        self.likes = json["likes"]["count"].stringValue
        self.comments = json["comments"]["count"].stringValue
        self.reposts = json["reposts"]["count"].stringValue
    }
}
