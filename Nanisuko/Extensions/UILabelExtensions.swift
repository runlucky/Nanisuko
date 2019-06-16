//
//  UILabelExtensions.swift
//  Nanisuko
//
//  Created by 福田走 on 2019/06/15.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    public var size: CGSize {
        return NSString(string: self.text ?? "").size(withAttributes: [.font: self.font])
    }
}
