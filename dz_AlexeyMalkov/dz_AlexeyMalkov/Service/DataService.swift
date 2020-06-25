//
//  DataService.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift

class DataService {
    
    func save(_ array: [Object]) {
        
        let realm = try? Realm()
        realm?.beginWrite()
        realm?.add(array)
        try? realm?.commitWrite()
    }
    
    func users() -> [UserList] {
        do {
            
            let realm = try Realm()
            let objects = realm.objects(UserList.self)
            return Array(objects)
        }
        catch {
            return []
        }
    }
    func groups() -> [GroupList] {
        do {
            
            let realm = try Realm()
            let objects = realm.objects(GroupList.self)
            return Array(objects)
        }
        catch {
            return []
        }
    }
    func photos() -> [Size] {
        do {
            
            let realm = try Realm()
            let objects = realm.objects(Size.self)
            return Array(objects)
        }
        catch {
            return []
        }
    }
}
