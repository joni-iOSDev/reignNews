//
//  Router.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation
import Alamofire

// MARK: - LISTENERS
public typealias InitRequest = ()->Void
public typealias FinishRequest = ()->Void
public typealias ErrorResponse = (Error?)->Void
public typealias FatalResponse = ()->Void
public typealias Response = (_ status: Int, _ response: [String:Any])->Void
public typealias EnvelopeFinish = ()->Void


protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint,
                 initRequest: @escaping InitRequest,
                 finishRequest: @escaping FinishRequest,
                 errorResponse: @escaping ErrorResponse,
                 fatal: @escaping FatalResponse,
                 onResponse: @escaping Response)
    func cancel()
    
}
/**
 - **Router**
 */
class Router<EndPoint: EndPointType>: NetworkRouter {
    
    func request(_ route: EndPoint,
                 initRequest: @escaping InitRequest,
                 finishRequest: @escaping FinishRequest,
                 errorResponse: @escaping ErrorResponse,
                 fatal: @escaping FatalResponse,
                 onResponse: @escaping Response) {
        initRequest()
        if let url = (route as! URLRequestConvertible).urlRequest {
            print("URL enpoint => \(url)")
        }
        AF.request(route as! URLRequestConvertible)
            .responseJSON { (response) in
                
                if let error = response.error {
                    errorResponse(error)
                }
                if let res = response.value as? [String:Any] {
                    print("respone => \(res)")
                    onResponse(response.response!.statusCode, res)
                }
            }
        finishRequest()
    }
    
    
    func cancel() {
        //
    }
    
    
}
