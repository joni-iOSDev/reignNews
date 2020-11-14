//
//  NewsTableViewCell.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell, NewsViewCellDelegate {
    
    @IBOutlet weak var newsTitle: UILabel!
    
    func show(title: String) {
        newsTitle.text = title
    }

}
