//
//  ThirdTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class ThirdTabTableViewController: UITableViewController {

    var feed: [FeedList] = [
        FeedList(headLine: "Хорошая погода", imageFeed: UIImage(named: "51"), feed: "Синоптики пообещали хорошую погоду. Теплая погода вернется в выходные — воздух  днем прогреется до +20 градусов. В субботу местами пройдет кратковременный дождь, столбики термометра покажут +20...+25 градусов. В воскресенье осадков не ожидается, температура составит +21...+23 градусов."),
        FeedList(headLine: "Идет строительство нового стадиона", imageFeed: UIImage(named: "52"), feed: "Объект рассчитан на 60 тыс. зрителей и сочетает в себе элементы традиционной архитектуры с модернистскими формами. Стадион адаптирован к жарким погодным условиям. Конструкция стадиона и сверхсовременная система кондиционирования позволит поддерживать на нем оптимальную температуру."),
        FeedList(headLine: "Осенью выходят новые модели iPhone 12", imageFeed: UIImage(named: "53"), feed: "В сети опубликованы цены на будущую линейку iPhone 12, которая должна быть представлена в сентябре. По информации инсайдеров, всего в этом году появится четыре новых модели, каждая из которых получит поддержку технологии 5G. Всего будет представлено два варианта iPhone 12 — на 128 ГБ и на 256 ГБ. Их стоимость составит $649 и $749 соответственно."),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        
        cell.headLineLabel.text = feed[indexPath.row].headLine
        cell.feedImage.image = feed[indexPath.row].imageFeed
        cell.feedLabel.text = feed[indexPath.row].feed
        
        return cell
    }

}
