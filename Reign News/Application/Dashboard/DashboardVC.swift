//
//  DashboardVC.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import UIKit

class DashboardVC: UIViewController {
    
    //Presenter
    var presenter: DashboardPresenter!
    
    //TableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DashboardPresenter(viewDelegate: self)
        presenter.viewDidLoad()
    }
    

}

extension DashboardVC: DashboardViewDelegate {
    func isUserSigned() {
        //
    }
    
    
}
