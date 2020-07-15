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
    
    var photo_id: String = ""
    var photo_1280: String = ""
    
    init(json: JSON) {
        self.photo_id = json["id"].stringValue
        self.photo_1280 = json["photo_1280"].stringValue
    }
}
