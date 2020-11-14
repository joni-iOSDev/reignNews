//
//  RNNews.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation

class RNNews {
    
    let createdAt: String?
    let title: String?
    
    init(json: [String:Any]) {
        self.createdAt = json["created_at"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        
    }
    
}
