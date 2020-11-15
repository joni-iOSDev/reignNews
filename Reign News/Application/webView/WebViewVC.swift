//
//  WebViewVC.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 15/11/2020.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    @IBOutlet weak var mWkWebView: WKWebView!
    var url: String? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeWebView))
        if let urlRequest = url, urlRequest != "" {
            mWkWebView.load(URLRequest(url: URL(string: urlRequest)!))
        }
        
        if url == nil {
            showAler()
        }
    }
    
    func showAler() {
        let alert = UIAlertController(title: "Web View", message: "The requested URL was not found on", preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.closeWebView()
        }
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func closeWebView() {
        self.dismiss(animated: true, completion: nil)
    }

}
