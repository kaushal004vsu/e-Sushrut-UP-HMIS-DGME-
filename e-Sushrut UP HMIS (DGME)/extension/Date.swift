//
//  Date.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 11/06/22.
//

import Foundation
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    
    
    
    func getDaysInMonth() -> Int{
        let calendar = Calendar.current

        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }
    
    static func getCurrentDate() -> String {

           let dateFormatter = DateFormatter()

           dateFormatter.dateFormat = "yyyy-MM-dd"

           return dateFormatter.string(from: Date())

       }
}
