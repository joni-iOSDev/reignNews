//
//  NewsEndpoint.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation

public enum NewsAPI {
    case popular
    case favorite
}

extension NewsAPI {
    
    var BASE_URL: String  {
        "http://hn.algolia.com/api/v1/search_by_date?query=ios"
    }
    
}
