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
    var height: Float = 0
    var width: Float = 0
    
        var aspectRatio: CGFloat {
        if height == 0 && width == 0 {
            return 0
        } else {
            return CGFloat(height)/CGFloat(width)
        }
    }
    
    init(json: JSON) {
        self.photoId = json["id"].stringValue
        self.photo = json["photo_604"].stringValue
        self.height = json["height"].floatValue
        self.width = json["width"].floatValue
    }
    
    init(json: [JSON]) {
        if !json.isEmpty {
        self.photoId = json[0]["photo"]["id"].stringValue
        self.photo = json[0]["photo"]["photo_604"].stringValue
        self.height = json[0]["photo"]["height"].floatValue
        self.width = json[0]["photo"]["width"].floatValue
        }
    }
}
