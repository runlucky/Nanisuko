//
//  DateExtensions.swift
//  Nanisuko
//
//  Created by 福田走 on 2019/06/17.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation

extension Date {
    enum format {
        case ISO8601
        case shortDate
    }
    
    func toString(_ format: format) -> String {
        switch format {
        case .ISO8601:
            return ISO8601DateFormatter().string(from: self)
        case .shortDate:
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .medium
            formatter.locale = Locale(identifier: "ja_JP")
            return formatter.string(from: self)
        }
    }
}
