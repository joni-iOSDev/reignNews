//
//  CoreDataManager.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 15/11/2020.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private let container: NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "newsDB")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(error)")
                return
            }
            print("Database ready")
        }
    }
    
    func persistentNews(data: [RNNews], completionHandler: @escaping ()->Void) {
        let context = container.viewContext
        for aNews in data {
            let dataNews = News(context: context)
            if let id = aNews.storyID {
                if matchNews(with: id) == false {
                    dataNews.author = aNews.author
                    dataNews.createdAt = aNews.createdAt
                    dataNews.storyID = Int32(id)
                    dataNews.storyTitle = aNews.storyTitle
                }
            }
            do {
                try context.save()
                print("Saved News")
            } catch {
                print("Error guardando usuario")
            }
        }
        completionHandler()
    }
    
    private func matchNews(with id: Int) -> Bool? {
        let fetechRequest: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            let result = try container.viewContext.fetch(fetechRequest)
            if !result.isEmpty {
                for i in result {
                    if Int(i.storyID) != id {
                        return false
                    } else {
                        return true
                    }
                }
            }
 
        } catch {
            print("load error")
        }
        return false
    }
    
    func deleteLogicNewsItem(id: Int) {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            for i in result {
                if Int(i.storyID) == id {
                    i.delete = true
                }
            }
        } catch {
            print("load error")
        }
    }
    
    func fetchNews() -> [RNNews] {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        var arrayNews = [RNNews]()
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            for i in result {
                arrayNews.append(RNNews(createdAt: i.createdAt,
                                        storyTitle: i.storyTitle,
                                        author: i.author,
                                        storyID: Int(i.storyID),
                                        delete: i.delete))
            }
            print("RN12 News count \(arrayNews.count)")
            let myNews = arrayNews.filter { (news) -> Bool in
                return news.delete == false
            }
            print("RN12 myNews count \(myNews.count)")

            return myNews
        } catch {
            print("load error")
        }
        return []
    }
    
}
