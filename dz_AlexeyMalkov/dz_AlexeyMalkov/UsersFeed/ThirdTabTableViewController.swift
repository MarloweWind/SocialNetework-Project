//
//  ThirdTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import FirebaseFirestore

class ThirdTabTableViewController: UITableViewController {

    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var feed: [FeedList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("testFeed").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents{
                    let data = document.data()
                    self.feed.append(FeedList(headLine: data["headLine"] as! String, imageFeed: data["imageFeed"] as! String, feed: data["feed"] as! String, usersAvatar: data["usersAvatar"] as! String, usersName: data["usersName"] as! String, commentsCount: data["commentsCount"] as! String, repostCount: data["repostCount"] as! String, viewsCount: data["viewsCount"] as! String))
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let object = feed[indexPath.row]
        cell.setFeed(object: object)
        
        return cell
    }

}
