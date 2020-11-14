//
//  HTTPTask.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation
import Alamofire

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: [String:String]?)
}
