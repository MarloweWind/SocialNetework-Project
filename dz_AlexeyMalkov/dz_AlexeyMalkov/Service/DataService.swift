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
    
    func save<T: Object>(_ array: [T]) {
        
        let realm = try? Realm()
        realm?.beginWrite()
        if let oldData = realm?.objects(T.self) {
            realm?.delete(Array(oldData))
        }
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
    func photos() -> [Photo] {
        do {
            
            let realm = try Realm()
            let objects = realm.objects(Photo.self)
            return Array(objects)
        }
        catch {
            return []
        }
    }
}
