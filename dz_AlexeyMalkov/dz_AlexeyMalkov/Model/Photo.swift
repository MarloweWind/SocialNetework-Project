//
//  Photo.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 21.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift

class Size: Object, Decodable {
    @objc dynamic var url = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
}

class PhotoResponseContainer: Decodable {
    let response: PhotoResponse
}

class PhotoResponse: Decodable {
    let items: [Photo]
}

class Photo: Object, Decodable {
    var sizes = List<Size>()
}
