import Foundation
import UIKit
import FSCalendar

extension FSCalendar {
//    func setFont() {
//        self.appearance.headerTitleFont = .NaNum(.extraBold, size: 18)
//        self.appearance.titleFont = .NaNum(.extraBold, size: 15)
//        self.appearance.weekdayFont = .NaNum(.regular, size: 12)
//    }
    
    func setColor() {
        self.appearance.todayColor = .clear
    }
    
    func defaultWeekDay() {
        self.locale = Locale(identifier: "ko_KR")
        self.appearance.weekdayFont = .Notos(.regular, size: 13)
    }
    
    func setApperance() {
        self.weekdayHeight = 60
        self.rowHeight = 44
    }
}
