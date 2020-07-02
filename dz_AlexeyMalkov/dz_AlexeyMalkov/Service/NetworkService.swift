//
//  NetworkService.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 21.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    
    var dataService: DataService = .init()
    let baseUrl = "https://api.vk.com"
    var apiKey = UserSession.shared.token
    let userDefaults = UserDefaults.standard
    
    func timeintervalSinceLastUpdate(for key: String) -> TimeInterval {
        let now = Date().timeIntervalSince1970
        let lastUpdate = userDefaults.value(forKey: key) as? Double ?? 0.0
        
        return now - lastUpdate
    }
    
    func loadFriends(userId: Int, completion: @escaping ([UserList]) -> Void) {
        let path = "/method/friends.get?"
        
        let parameters: Parameters = [
            "userId": userId,
            "fields": "bdate,photo_100",
            "access_token": apiKey,
            "v": 5.103
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            print(response)
            let response = try? JSONDecoder().decode(FriendResponseContainer.self, from: data)
            let users = response?.response.items ?? []
            self.dataService.save(users)
            self.userDefaults.set(Date().timeIntervalSince1970, forKey: UserList.className())
            
            completion(users)
        }
    }
    
    func loadPhotos(userId: Int, completion: @escaping ([Photo]) -> Void) {
        let path = "/method/photos.get?"
        let parameters: Parameters = [
            "userId": userId,
            "album_id": "wall",
            "owner_id": userId,
            "access_token": apiKey,
            "v": 5.103
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            print(response)
            let response = try? JSONDecoder().decode(PhotoResponseContainer.self, from: data)
            let photos = response?.response.items ?? []
            self.dataService.save(photos)
            self.userDefaults.set(Date().timeIntervalSince1970, forKey: Photo.className())
            
            completion(photos)
        }
    }
    
    func loadUserGroups(userId: Int, completion: @escaping ([GroupList]) -> Void) {
        let path = "/method/groups.get?"
        let parameters: Parameters = [
            "userId": userId,
            "extended": 1,
            "fields": "name,photo_100",
            "access_token": apiKey,
            "v": 5.103
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            print(response)
            let response = try? JSONDecoder().decode(CommunityResponseContainer.self, from: data)
            let groups = response?.response.items ?? []
            self.dataService.save(groups)
            self.userDefaults.set(Date().timeIntervalSince1970, forKey: GroupList.className())
            
            completion(groups)
        }
    }
    
    func loadAllGroups(q: String, completion: @escaping ([GroupList]) -> Void) {
        let path = "/method/groups.search?"
        let parameters: Parameters = [
            "q": q,
            "access_token": apiKey,
            "fields": "name,photo_100",
            "v": 5.103
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            print(response)
            let response = try? JSONDecoder().decode(CommunityResponseContainer.self, from: data)
            let groups = response?.response.items ?? []
            self.dataService.save(groups)
            self.userDefaults.set(Date().timeIntervalSince1970, forKey: GroupList.className())
            
            completion(groups)
        }
    }
}
