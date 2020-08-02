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

class ThirdTabTableViewController: UITableViewController {

    var castomRefreshControl = UIRefreshControl()
    private let queue: DispatchQueue = DispatchQueue(label: "feedQueue", qos: .userInteractive, attributes: [.concurrent])
    var feed: [FeedList] = []
    
    func addRefreshControl() {
         castomRefreshControl.attributedTitle = NSAttributedString(string: "Обновление...")
         castomRefreshControl.addTarget(self, action: #selector(addRefreshTable), for: .valueChanged)
         tableView.addSubview(castomRefreshControl)
     }
    
     @objc func addRefreshTable() {
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
             self.castomRefreshControl.endRefreshing()
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            loadFeed() { news in
                self.feed = news
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        addRefreshTable()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let object = feed[indexPath.row]
        cell.setFeed(object: object)
        let url = URL(string: feed[indexPath.row].feedPhoto.photo)
        cell.feedImage.kf.setImage(with: url)
        
        
        return cell
    }

}
