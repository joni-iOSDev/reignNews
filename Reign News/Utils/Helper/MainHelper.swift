//
//  MainHelper.swift
//  Reign News
//
//  Created by Jonatan Gonzalez on 14/11/2020.
//

import Foundation

class MainHelper {
    
    class func getDateFrom(_ stringDate: String) -> String? {
        let dateFormaterGet = DateFormatter()
        dateFormaterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormaterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy HH:mm"
        guard let date = dateFormaterGet.date(from: stringDate) else {
            return nil
        }
        return dateFormatterPrint.string(from: date)
    }
}
