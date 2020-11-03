//
//  NetworkService.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 21.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
    
    let realm = try! Realm()
    var apiKey = UserSession.shared.token
    var id = UserSession.shared.userId
    var count = UserSession.shared.count

    func loadFriends() {
        let parameters : Parameters = [
            "user_id" : id,
            "access_token" : apiKey,
            "fields" : "bdate, photo_50",
            "v" : "5.110"
        ]
        AF.request("https://api.vk.com/method/friends.get", parameters: parameters).validate().responseJSON { (responce) in
            let json = JSON(responce.value!)
            let userList = json["response"]["items"]
            
            for users in userList{
                let user = UserListRealm()
                user.id = users.1["id"].intValue
                user.firstName = users.1["first_name"].stringValue
                user.lastName = users.1["last_name"].stringValue
                user.avatar = users.1["photo_50"].stringValue
                
                do{
                    try realm.write {
                        realm.add(user, update: .all)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadPhotos(user_id: String, completion: @escaping ([Photo]) -> ()) {
        let parameters : Parameters = [
            "owner_id" : "\(user_id)",
            "album_id" : "profile",
            "access_token" : apiKey,
            "v" : "5.60"
        ]
        AF.request("https://api.vk.com/method/photos.get", parameters: parameters).responseJSON { (responce) in
            let json = JSON(responce.value!)
            let photos = json["response"]["items"].map{
                Photo(json: $0.1)
            }
            completion(photos)
        }
    }

    func loadUserGroups() {
        let parameters : Parameters = [
            "user_id" : id,
            "access_token" : apiKey,
            "extended" : "1",
            "v" : "5.110"
        ]
        AF.request("https://api.vk.com/method/groups.get", parameters: parameters).responseJSON { (responce) in
            let json = JSON(responce.value!)
            let groupList = json["response"]["items"]

            for groups in groupList{
                let group = GroupListRealm()
                group.groupId = groups.1["id"].intValue
                group.groupName = groups.1["name"].stringValue
                group.groupAvatar = groups.1["photo_50"].stringValue
                
                do{
                    try realm.write {
                        realm.add(group, update: .all)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadGlobalGroups(searchText: String, completion: @escaping ([GroupList]) -> ()) {
        let parameters : Parameters = [
            "user_id" : id,
            "access_token" : apiKey,
            "q" : "\(searchText)",
            "v" : "5.110"
        ]
        AF.request("https://api.vk.com/method/groups.search", parameters: parameters).responseJSON { (responce) in
            let json = JSON(responce.value!)
            let searchGroups = json["response"]["items"].map{
                GroupList(json: $0.1)
            }
            completion(searchGroups)
        }
    }

    func loadFeed(completion: @escaping ([FeedList]) -> ()){
            let parameters: Parameters = [
                "user_id" : id,
                "access_token" : apiKey,
                "filters" : "post",
                "v" : "5.60",
                "count" : count + 10
            ]
        AF.request("https://api.vk.com/method/newsfeed.get", parameters: parameters).responseJSON { (responce) in
            let json = JSON(responce.value!)
            let feed = json["response"]["items"].map{
                FeedList.init(json: $0.1)
            }
            completion(feed)
        }
    }

