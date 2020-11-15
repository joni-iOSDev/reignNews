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
    let storyID: Int?
    var delete: Bool?
    
    init(createdAt: String?, storyTitle: String?,author: String?, storyID: Int?, delete: Bool) {
        self.createdAt = createdAt
        self.storyID = storyID
        self.author = author
        self.storyTitle = storyTitle
        self.delete = delete
    }
    
    init(json: [String:Any]) {
        createdAt = json["created_at"] as? String ?? "Created Unknown"
        storyTitle = json["story_title"] as? String ?? "Title Unknown"
        author = json["author"] as? String ?? "Author Unknown"
        storyID = json["story_id"] as? Int ?? -1

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
