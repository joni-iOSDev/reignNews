//
//  DashboardPresenter.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import Foundation
import SwiftDate


protocol NewsViewCellDelegate {
    func show(title: String, authorNews: String, created: String)
}

protocol DashboardViewDelegate: class {
    func refreshData()
    func setTitleNavigation(title: String)
    func setupRefreshControl()
    func refreshNews()
    func finishRefreshControl()
    func goToWebView(with url: String)
}

//DashboardPresenterImplmentation
class DashboardPresenter {
    
    fileprivate weak var view: DashboardViewDelegate?
    private let services = NetworkManager()
    private let manager = CoreDataManager()
    var news = [RNNews]()
    
    
    var numberOfNews: Int {
        return news.count
    }
    
    init(viewDelegate: DashboardViewDelegate) {
        self.view = viewDelegate
    }
    
    
    func viewDidLoad() {
        getNews()
        view?.setTitleNavigation(title: "Reign News")
        view?.setupRefreshControl()
    }
    
    func getNews(by data: String = "iOS", page: Int = 0) {
        services.search(page: page, by: data) {
            //
        } finishRequest: {
            //
            
        } errorResponse: {[weak self] (RNError) in
            //TODO: error manager
            //if error is conexion fail to internet
            guard let self = self else { return }
            self.fetchNewsPersistent()
        } fatal: {
            //
        } onResponse: { [weak self ](responseCode, arrayNews) in
            guard let self = self else { return }
            self.sortdNews(array: arrayNews)
        }
    }
    
    private func fetchNewsPersistent() {
        news = manager.fetchNews()
        self.view?.refreshData()
        self.view?.finishRefreshControl()
    }
    
    func sortdNews(array: [RNNews]) {
        let ordered = array.sorted { (news1, news2) -> Bool in
            return (news1.createdAt?.toDate())! > (news2.createdAt?.toDate())!
        }
        manager.persistentNews(data: ordered) { [ weak self ] in
            guard let self = self else { return }
            self.fetchNewsPersistent()
        }
    }
    
    func configureCell(cell: NewsViewCellDelegate, row: Int) {
        let aNews = news[row]
        let createdFormated = MainHelper.getDateFrom(aNews.createdAt ?? "") ?? "Date Unknown"
        cell.show(title: aNews.storyTitle ?? "Title Unknown",
                  authorNews: aNews.author ?? "Author Unknown", created: createdFormated)
    }

    func deleteNewsItem(at: Int) {
        if let id = news[at].storyID {
            news[at].delete = true
            manager.deleteLogicNewsItem(id:id)
            news.remove(at: at)
        }

    }
    
    func selectedCell(at: Int) {
        let url = news[at].storyURL ?? ""
        view?.goToWebView(with: url)
    }

    
}
