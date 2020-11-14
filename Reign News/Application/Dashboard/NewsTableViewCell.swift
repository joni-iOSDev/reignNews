//
//  NewsTableViewCell.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell, NewsViewCellDelegate {
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    func show(title: String, authorNews: String, created: String) {
        newsTitle.text = title
        createdDate.text = created
        author.text = "Author: \(authorNews)"
    }

}
