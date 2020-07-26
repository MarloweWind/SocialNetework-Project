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

    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var ViewLike: LikeView!
    @IBOutlet weak var avatarImage: FriendAvatarImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setFeed(object: FeedList){
        let firstURL = URL(string: object.imageFeed)
        let secondURL = URL(string: object.usersAvatar)
        self.feedImage.kf.setImage(with: firstURL)
        self.avatarImage.kf.setImage(with: secondURL)
        self.feedLabel.text = object.feed
        self.headLineLabel.text = object.headLine
        self.nameLabel.text = object.usersName
        self.commentsLabel.text = object.commentsCount
        self.repostLabel.text = object.repostCount
        self.viewsLabel.text = object.viewsCount
    }
}
