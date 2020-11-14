//
//  DashboardPresenter.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import Foundation

protocol NewsViewCellDelegate {
    func show(title: String)
}

protocol DashboardViewDelegate: class {
    func isUserSigned()
    func refreshData()
    func setTitleNavigation(title: String)
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
        view?.setTitleNavigation(title: "News")
    }
    
    func getNews() {
        services.search(page: 0, by: "iOS") {
            //
        } finishRequest: {
            //
        } errorResponse: { (RNError) in
            //
        } fatal: {
            //
        } onResponse: { [weak self ](responseCode, arrayNews) in
            guard let self = self else { return }
            self.news = arrayNews
            self.view?.refreshData()

        }
    }
    
    func configureCell(cell: NewsViewCellDelegate, row: Int) {
        let aNews = news[row]
        cell.show(title: aNews.storyTitle ?? "title Unknown")
    }

    
}
