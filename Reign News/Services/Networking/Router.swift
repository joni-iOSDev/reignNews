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
                 response: Response)
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
                 response: (Int, [String : Any]) -> Void) {
        
        let request = route as! URLRequestConvertible
        print("PATH: => \(String(describing: request.urlRequest?.url))")

        AF.request(request).responseJSON(completionHandler: { (response) in
            if let res = response.value as? [String:Any] {
                print(res)
            }
        })
    }
    
    
    func cancel() {
        //
    }
    
    
}
