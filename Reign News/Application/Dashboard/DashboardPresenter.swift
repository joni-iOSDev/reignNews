//
//  DashboardPresenter.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import Foundation

protocol DashboardViewDelegate: class {
    func isUserSigned()
}

//DashboardPresenterImplmentation
class DashboardPresenter {
    
    fileprivate weak var view: DashboardViewDelegate?
    private let services = NetworkManager()
    
    
    init(viewDelegate: DashboardViewDelegate) {
        self.view = viewDelegate
    }
    
    
    func viewDidLoad() {
        services.router.request(.search(byDate: "iOS")) {
            //
        } finishRequest: {
            //
        } errorResponse: { (errorMessage) in
            //
        } response: { (statusCode, response) in
            //
        }
    }
    
    func viewDidAppear() {
        //
    }
    
    
}
