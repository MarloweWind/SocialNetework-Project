//
//  FeedTableViewCell.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var ViewLike: LikeView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setFbFeed(object: FeedListFireBase){
        let firstURL = URL(string: object.imageFeed)
        self.feedImage.kf.setImage(with: firstURL)
        self.feedLabel.text = object.feed
        self.commentsLabel.text = object.commentsCount
        self.repostLabel.text = object.repostCount
        self.viewsLabel.text = object.viewsCount
    }
    
    func setFeed(object: FeedList){
//        let url = URL(string: object.imageURL)
//        self.feedImage.kf.setImage(with: url)
        self.feedLabel.text = object.text
        self.viewsLabel.text = object.views
        self.likeLabel.text = object.likes
        self.commentsLabel.text = object.comments
        self.repostLabel.text = object.reposts

    }
}
