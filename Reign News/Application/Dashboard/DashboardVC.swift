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
    private let refreshControl = UIRefreshControl()
    
    //properties
    let cellHeight: CGFloat = 125
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
        presenter = DashboardPresenter(viewDelegate: self)
        presenter.viewDidLoad()
    }
    

}

extension DashboardVC: DashboardViewDelegate {
    func goToWebView(with url: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let webView = sb.instantiateViewController(withIdentifier: "webView") as? WebViewVC
        webView?.url = url
        let navController = UINavigationController(rootViewController: webView!)
        present(navController, animated: true, completion: nil)
    }
    
    
    @objc func refreshNews() {
        presenter.getNews()
    }
    
    func finishRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    
    func setupRefreshControl() {
        tableViewNews.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    func setTitleNavigation(title: String) {
        navigationItem.title = title
    }
    
    
    func refreshData() {
        tableViewNews.reloadData()
    }
    
}// DashboardViewDelegate


extension DashboardVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectedCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteNewsItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
