//
//  FeedAdapter.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 09.09.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import Foundation

class FeedAdapter{
    
    func adapterLoadFeed(completion: @escaping ([FeedList]) -> ()){
        loadFeed { (news) in
            completion(news)
        }
    }
    
}
