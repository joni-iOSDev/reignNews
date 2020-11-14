//
//  MainPresenter.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation

protocol MainViewDelegate: class {
    func isUserSigned()
}


class MainPresenter {
        
    fileprivate weak var view: MainViewDelegate?
    private let services = NetworkManager()
    
    init(viewDelegate: MainViewDelegate) {
        self.view = viewDelegate
    }
    
    func viewDidLoad() {
        print("viewDidLoad")
        
    }
    
    func viewDidAppear() {
        print("viewDidAppear")
    }
    
    
}
