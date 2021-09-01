//
//  File.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/01.
//

import Foundation

extension Int {
    var mmHour: String {
        if self < 10 && self >= 1 {
            return "0\(self)"
        } else if self < 1 {
            return "00"
        }
        return "\(self)"
        
    }
    var mmMinute: String {
        if self < 10 && self >= 1 {
            return "0\(self)"
        } else if self < 1 {
            return "00"
        }
        return "\(self)"

    }
}
