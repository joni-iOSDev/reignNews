//
//  NetworkManager.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation

struct NetworkManager {
    
    static let environment: NetworkEnvironment = .prod
    fileprivate let router =  Router<NewsAPI>()
    
    func search(page: Int,
                by data: String,
                initRequest: @escaping InitRequest,
                finishRequest: @escaping FinishRequest,
                errorResponse: @escaping ErrorResponse,
                fatal: @escaping FatalResponse,
                onResponse: @escaping (Int, [RNNews]) -> Void) {
        
        router.request(.search(byDate: data, page: page),
                       initRequest: initRequest,
                       finishRequest: finishRequest,
                       errorResponse: errorResponse,
                       fatal: fatal) { (statusCode, resopnseJSON) in
            onResponse(statusCode, RNNews.getArray(json: resopnseJSON))

        }
        
    }
    
}
