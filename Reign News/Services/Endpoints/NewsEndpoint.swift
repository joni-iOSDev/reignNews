//
//  NewsEndpoint.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation
import Alamofire

enum NetworkEnvironment {
    case qa
    case prod
    case develop
}

public enum NewsAPI: URLRequestConvertible {
    case search(byDate: String, page: Int)
    case favorite(params:[String:String])
}

extension NewsAPI: EndPointType {

    var environmentBaseURL: String  {
        switch NetworkManager.environment {
        case .qa:
            return "http://hn.algolia.com/api/v1"
        case .develop:
            return "http://hn.algolia.com/api/v1"
        case .prod:
            return "http://hn.algolia.com/api/v1"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("Base URL not configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search_by_date"
        case .favorite:
            return "favorite"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .favorite:
            return .get
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = httpMethod
        
        switch self {
        case .favorite(params: let paramsFavorite):
            request = try URLEncodedFormParameterEncoder().encode(paramsFavorite,
                                                                  into: request)
        case .search(byDate: let searchParams, page: let page):
            let params = [
                "query": searchParams,
                "page" : "\(page)"
            ]
            request = try URLEncodedFormParameterEncoder().encode(params,
                                                                  into: request)
        }
        return request
        
    }
    
}
