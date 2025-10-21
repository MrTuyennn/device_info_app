//
//  LocaleApp.swift
//  
//
//  Created by Nguyen Ngoc Tuyen on 21/10/25.
//

import Foundation

struct LocaleApp {
    let languageCode: String
    let countryCode: String
    
    func toJson() -> [String: Any] {
        return [
            "languageCode": languageCode,
            "countryCode": countryCode
        ]
    }
}
