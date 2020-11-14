//
//  RNNews.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation

class RNNews {
    
    let createdAt: String?
    let storyTitle: String?
    let author: String?
    
    init(json: [String:Any]) {
        self.createdAt = json["created_at"] as? String ?? "Created Unknown"
        self.storyTitle = json["story_title"] as? String ?? "Title Unknown"
        self.author = json["author"] as? String ?? "Author Unknown"

    }
    
    static func getArray(json: [String:Any]) -> [RNNews] {
        
        var array = [RNNews]()
        
        guard let newsJSON = json["hits"] as? [[String:Any]] else {
            print("RN123 request array parse error")
            return array
        }
        
        for aNewsJSON in newsJSON {
            let news = RNNews(json: aNewsJSON)
            array.append(news)
        }
        return array
    }
    
    
}
