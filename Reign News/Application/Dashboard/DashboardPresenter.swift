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
}

//DashboardPresenterImplmentation
class DashboardPresenter {
    
    fileprivate weak var view: DashboardViewDelegate?
    private let services = NetworkManager()
    
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
    
    func getNews() {
        services.search(page: 0, by: "iOS") {
            //
        } finishRequest: { [weak self] in
            guard let self = self else { return }
            self.view?.finishRefreshControl()
            
        } errorResponse: { (RNError) in
            //
        } fatal: {
            //
        } onResponse: { [weak self ](responseCode, arrayNews) in
            guard let self = self else { return }
            self.sortdNews(array: arrayNews)
            self.view?.refreshData()
        }
    }
    
    func sortdNews(array: [RNNews]) {
        let ordered = array.sorted { (news1, news2) -> Bool in
            return (news1.createdAt?.toDate())! > (news2.createdAt?.toDate())!
        }
        news = ordered
    }
    
    func configureCell(cell: NewsViewCellDelegate, row: Int) {
        let aNews = news[row]
        let createdFormated = MainHelper.getDateFrom(aNews.createdAt ?? "") ?? "--/--/--"
        cell.show(title: aNews.storyTitle!, authorNews: aNews.author!, created: createdFormated)
    }

    
}
