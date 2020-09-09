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

    private let queue: DispatchQueue = DispatchQueue(label: "feedQueue", qos: .userInteractive, attributes: [.concurrent])
    var feed: [FeedList] = []
    var isLoading: Bool = false
    var feedAdapter = FeedAdapter()
    
    func setupRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshImage), for: .valueChanged)
    }
    
    @objc func refreshImage(){
        self.feed.removeAll()
        self.tableView.reloadData()
        feedAdapter.adapterLoadFeed() { news in
            self.feed = news
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        DispatchQueue.global().async {
            self.feedAdapter.adapterLoadFeed() { news in
                self.feed = news
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        setupRefreshControl()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableWidth = tableView.bounds.width
        let cellHeight = tableWidth * feed[indexPath.row].feedPhoto.aspectRatio
        return cellHeight
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

extension ThirdTabTableViewController: UITableViewDataSourcePrefetching{

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let max = indexPaths.map({$0.row}).max() else {return}
        if max > feed.count - 3 {
            if !isLoading{
                isLoading = true
                count += 1
                loadFeed() { news in
                self.feed = news
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}
