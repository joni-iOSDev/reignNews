//
//  MainVC.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 13/11/2020.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(viewDelegate: self)
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
}

extension MainVC: MainViewDelegate {
    func isUserSigned() {
        //
    }
}
