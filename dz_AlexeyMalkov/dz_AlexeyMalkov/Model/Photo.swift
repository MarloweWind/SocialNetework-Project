//
//  Photo.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 21.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class PhotoResponseContainer: Decodable {
    let response: PhotoResponse
}

class PhotoResponse: Decodable {
    let items: [Photo]
}

class Photo: Decodable {
    dynamic var sizes: [Size]
}

class Size: Decodable {
    dynamic var url: String
    dynamic var width = 0
    dynamic var height = 0
}
