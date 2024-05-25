//
//  SecondScreen.swift
//  Weatherly
//
//  Created by Aya Mostafa on 25/05/2024.
//

import SwiftUI
import Kingfisher

struct SecondScreen: View {
    var selectedDay : Forecastday?
    @EnvironmentObject var theme: HandleThem
    let baseURL = "https:"
    var body: some View {
        ZStack{
            Image(theme.isTime ? "light" : "dark")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
            if let day = selectedDay {
                ScrollView{
                    VStack{
                        ForEach(displayHours(for: day), id: \.time) { hour in
                            HStack {
                                let hourFormat = convertTo12HourFormat(timeString: hour.time ?? "")
                                Text(hourFormat)
                                    .font(.system(size: 25))
                                    .frame(width : 160)
                                    .foregroundColor(theme.isTime ? .black : .white)
                                KFImage.url(URL(string: baseURL+(hour.condition?.icon ?? "")))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50 , height: 50)
                                Spacer()
                                Text("\(Int(hour.tempC ?? 0.0)) °")
                                    .font(.system(size: 25))
                                    .padding(.trailing,55)
                                    .foregroundColor(theme.isTime ? .black : .white)
                                
                            }
                            .padding()
                        }
                    }
                    .padding(.top,150)
                }
            }
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
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen(selectedDay: Forecastday.mockData())
                   .environmentObject(HandleThem())
    }
}
