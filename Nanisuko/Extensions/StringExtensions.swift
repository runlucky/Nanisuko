//
//  StringExtensions.swift
//  Nanisuko
//
//  Created by 福田走 on 2019/06/16.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        guard let time = self.convertNumber().toTime() else {
            return nil
        }

        var component = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        component.hour = time.hour
        component.minute = time.minute

        return Calendar.current.date(from: component)
    }

    private func convertNumber() -> String {
        var text = self.replace("ななじ|しちじ", to: "7:")
        text = text.replace("はちじ", to: "8:")
        text = text.replace("くじ", to: "9:")
        text = text.replace("じゅうじ", to: "10:")
        text = text.replace("じゅういちじ", to: "11:")

        text = text.replace("(１|一|いち|イチ)", to: "1")
        text = text.replace("(２|ニ|に|ニ)", to: "2")
        text = text.replace("(３|三|さん|サン)", to: "3")
        text = text.replace("(４|四|よん|ヨン)", to: "4")
        text = text.replace("(５|五|ご|ゴ)", to: "5")
        text = text.replace("(６|六|ろく|ロク)", to: "6")
        text = text.replace("(７|七|しち|なな|シチ|ナナ)", to: "7")
        text = text.replace("(８|八|はち|ハチ)", to: "8")
        text = text.replace("(９|九|く|きゅう|ク|キュウ)", to: "9")
        text = text.replace("(０)", to: "0")

        text = text.replace("(：|じ|時)", to: ":")
        text = text.replace("(はん|半)", to: "30")

        return text;
    }

    public func replace(_ regex: String, to: String) -> String {
        return replacingOccurrences(
                of: regex,
                with: to,
                options: .regularExpression,
                range: self.range(of: self))
    }

    public func match(_ pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let matched = regex.firstMatch(in: self, range: NSRange(location: 0, length: self.count)) else {
            return ""
        }

        return (self as NSString).substring(with: matched.range(at: 1))
    }

    private func toTime() -> (hour: Int?, minute: Int?)? {
        let time = (hour: self.getHour(), minute: self.getMinute())
        if time.hour != nil {
            return time
        }

        if self.starts(with: "はやすこ") { return (hour: 19, minute: 30) }
        if self.starts(with: "おそすこ") { return (hour: 21, minute: 0) }
        if self.starts(with: "おおおそすこ") { return (hour: 23, minute: 0) }
        return nil
    }

    private func getHour() -> Int? {
        guard let reg = self.match("(\\d{1,2}):"),
              let result = Int(reg) else {
            return nil
        }

        switch result {
        case 6...12: return result + 12
        default: return result
        }
    }

    private func getMinute() -> Int? {
        guard let reg = self.match(":(\\d{1,2})"),
              let result = Int(reg) else {
            return nil
        }
        return result
    }
}

extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        switch self {
        case nil: return true
        case "": return true
        default: return false
        }
    }
}