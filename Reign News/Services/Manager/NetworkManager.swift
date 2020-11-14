//
//  NetworkManager.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation

struct NetworkManager {
    
    static let environment: NetworkEnvironment = .prod
    let router =  Router<NewsAPI>()
    
    func search(page: Int,
                by data: String,
                initRequest: @escaping InitRequest,
                finishRequest: @escaping FinishRequest,
                errorResponse: @escaping ErrorResponse,
                response: (Int, [String : Any]) -> Void) {
        
        router.request(.search(byDate: data),
                       initRequest: initRequest,
                       finishRequest: finishRequest,
                       errorResponse: errorResponse,
                       response: response)
    }
    
}
