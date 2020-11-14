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
    @IBOutlet weak var tableViewNews: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
        presenter = DashboardPresenter(viewDelegate: self)
        presenter.viewDidLoad()
    }
    

}

extension DashboardVC: DashboardViewDelegate {
    func setTitleNavigation(title: String) {
        navigationItem.title = title
    }
    
    
    func refreshData() {
        tableViewNews.reloadData()
    }
    
    func isUserSigned() {
        //
    }
}// DashboardViewDelegate


extension DashboardVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
} // UITableViewDelegate

extension DashboardVC: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCellIdentifier",
                                                     for: indexPath) as! NewsTableViewCell
        
        presenter.configureCell(cell: newsCell, row: indexPath.row)
        
        return newsCell
    }
    
    
} // UITableViewDataSource
