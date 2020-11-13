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
    func request(_ route: EndPoint, completion: @escaping InitRequest)
    func cancel()
    
}


class Router<EndPoint: EndPointType>: NetworkRouter {
    
    func request(_ route: EndPoint, completion: @escaping InitRequest) {
        //
    }
    
    func cancel() {
        //
    }
    
    
}
