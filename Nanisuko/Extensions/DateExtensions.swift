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
    }
    
    func toString(_ format: format) -> String {
        switch format {
        case .ISO8601:
            return ISO8601DateFormatter().string(from: self)
        }
    }
}
