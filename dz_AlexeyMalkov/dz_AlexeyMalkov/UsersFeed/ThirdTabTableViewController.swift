//
//  ThirdTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ThirdTabTableViewController: UITableViewController {

    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var feed: [FeedList] = []
    var photoService: PhotoService?

    override func viewDidLoad() {
        super.viewDidLoad()
        fbFeedData()
        photoService = PhotoService(container: tableView)
    }
    
    func fbFeedData(){
        DispatchQueue.global().async {
            self.db.collection("testFeed").getDocuments { (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    for document in snapshot!.documents{
                        let data = document.data()
                        self.feed.append(FeedList(imageFeed: data["imageFeed"] as! String, feed: data["feed"] as! String, commentsCount:    data["commentsCount"] as! String, repostCount: data["repostCount"] as! String, likeCount: data["likeCount"] as! String))
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
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
        cell.feedImage.image = photoService?.photo(atIndexpath: indexPath, byUrl: object.imageFeed)
        
        return cell
    }
}
