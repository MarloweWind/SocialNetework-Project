//
//  Photo.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 21.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

struct Photo {
    
    var photoId: String = ""
    var photo: String = ""
    
    init(json: JSON) {
        self.photoId = json["id"].stringValue
        self.photo = json["photo_604"].stringValue
    }
    
    init(json: [JSON]) {
        if !json.isEmpty {
        self.photoId = json[0]["photo"]["id"].stringValue
        self.photo = json[0]["photo"]["photo_604"].stringValue
        }
    }
}
