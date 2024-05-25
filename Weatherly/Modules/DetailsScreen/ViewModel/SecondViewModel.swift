//
//  SecondViewModel.swift
//  Weatherly
//
//  Created by Aya Mostafa on 25/05/2024.
//

import Foundation
class SecondViewModel {
    
    static let shared = SecondViewModel()
    
    private init() {}
    
    func displayHours (for day : Forecastday) -> [Hour] {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let today = dayFormatter.string(from: currentDate)
        
        if let selectedDay = day.date, selectedDay == today {
            return day.hour?.filter{ hour in
                if let timeOfHour = hour.time, let date = dateFormatter.date(from: timeOfHour){
                    return date >= currentDate
                }
                   return false
            } ?? []
        }else {
            return day.hour ?? []
        }
    }
    
    
    func convertTo12HourFormat(timeString: String, format: String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: timeString) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        }
        return timeString
    }
    
}
