//
//  DateExtension.swift
//  VariableHolidays
//
//  Created by student on 12/03/2024.
//

import Foundation
extension Date {
    static func fromYMD(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        components.timeZone = TimeZone(abbreviation: "GMT")
        return calendar.date(from: components)!
    }
    mutating func addDays(numberOfDays: Int) {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.hour = 24 * numberOfDays
        let newDate = calendar.date(byAdding: dateComponent, to: self) ?? Date()
        self = newDate
    }
    func dayNumberOfWeek() -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday!
    }
    var ymd : DateComponents {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: self)
            return components
        }
    }
    
    func isSameDate(date: Date) -> Bool {
        let me = self.ymd
        let other = date.ymd
        if me == other {
            return true
        }
        return false
    }
    func daysBetween(date: Date) -> Int {
        let calendar = Calendar.current
        let dateMe = calendar.startOfDay(for: self)
        let dateOther = calendar.startOfDay(for: date)
        let numberOfDays = calendar.dateComponents([.day], from: dateMe, to: dateOther)
        return numberOfDays.day!
    }
    func isWeekend() -> Bool {
        switch self.dayNumberOfWeek() {
        case 1,7: //1 to niedziela, 7 to sobota
            return true
        default:
            return false
        }
    }
    func isHoliday() -> Bool {
            //dziala
            var Holiday = false;
            //dni wolne od pracy 1 stycznia itd...
            if(self.ymd.day == 1 && self.ymd.month == 1){
                Holiday = true
            }
            if(self.ymd.day == 6 && self.ymd.month == 1){
                Holiday = true
            }
            if(self.ymd.day == 1 && self.ymd.month == 5){
                Holiday = true
            }
            if(self.ymd.day == 3 && self.ymd.month == 5){
                Holiday = true
            }
            if(self.ymd.day == 15 && self.ymd.month == 8){
                Holiday = true
            }
            if(self.ymd.day == 1 && self.ymd.month == 11){
                Holiday = true
            }
            if(self.ymd.day == 11 && self.ymd.month == 11){
                Holiday = true
            }
            if(self.ymd.day == 25 && self.ymd.month == 12){
                Holiday = true
            }
            if(self.ymd.day == 26 && self.ymd.month == 12){
                Holiday = true
            }
            return Holiday
    }
    func isEaster() -> Bool {
        
        var Holiday = false;
        //obliczenie wielkanocy
        let a = self.ymd.year!%19
        let b = Int(self.ymd.year!/100)
        let c = self.ymd.year!%100
        let d = Int(b/4)
        let e = b%4
        let f = Int((b+8)/25)
        let g = Int((b-f+1)/3)
        let h = (19*a+b-d-g+15)%30
        let i = Int(c/4)
        let k = c%4
        let l = (32+2*e+2*i-h-k)%7
        let m = Int((a+11*h+22*l)/451)
        let p = (h+l-7*m+114)%31
        let day = p+1
        let month = Int((h+l-7*m+114)/31)
        
        let easter = Date.fromYMD(year: self.ymd.year!, month: month, day: day)
        var monday = easter
        monday.addDays(numberOfDays: 1)
        var Corpus_Christi = easter
        Corpus_Christi.addDays(numberOfDays: 60)
        if (self.ymd.day == monday.ymd.day && self.ymd.month == monday.ymd.month){
            Holiday = true;
        }
        if (self.ymd.day == Corpus_Christi.ymd.day && self.ymd.month == Corpus_Christi.ymd.month){
            Holiday = true;
        }
        return Holiday
    }
    
    
    func countWorkdays(date: Date) -> Int {
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: self)
            let endDate = calendar.startOfDay(for: date)
            
            let numberOfDays = calendar.dateComponents([.day], from: startDate, to: endDate).day!
            var workdays = 0
            var currentDate = startDate
        
            for _ in 0..<numberOfDays {
                if !currentDate.isWeekend() && !currentDate.isHoliday() && !currentDate.isEaster(){
                workdays += 1 //dodawanie dni roboczych
              }
                currentDate.addDays(numberOfDays: 1) //+1 dzien
            }

        return workdays
    }

}
