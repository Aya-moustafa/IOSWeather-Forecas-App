//
//  ForecastDayRow.swift
//  Weatherly
//
//  Created by Aya Mostafa on 19/05/2024.
//

import SwiftUI
import Kingfisher

func dayOfWeek(from dateString: String, format: String = "yyyy-MM-dd") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    return nil
}

struct ForecastDayRow: View {
    var dayForecast : Forecastday
    var isToday = false
    @EnvironmentObject var theme: HandleThem
    let baseURL = "https:"
    var body: some View {
        HStack{
            if let dayOfWeekString = dayOfWeek(from: dayForecast.date ?? ""){
                Text(dayOfWeekString)
                    .frame(width : 150)
                    .font(.headline)
                    .padding(.leading,-30)
                    .foregroundColor(theme.isTime ? .black : .white)
                KFImage.url(URL(string: baseURL+(dayForecast.day?.condition?.icon ?? "")))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50 , height: 50)
                    .padding(.leading,-25)
                    .foregroundColor(theme.isTime ? .black : .white)
                Text(String(dayForecast.day?.maxtempC ?? 0)+"°")
                    .font(.headline)
                    .padding(.trailing,10)
                    .foregroundColor(theme.isTime ? .black : .white)
                Text(String(dayForecast.day?.mintempC ?? 0)+"°")
                    .font(.headline)
                    .padding(.trailing,10)
                    .foregroundColor(theme.isTime ? .black : .white)
    
            }else{
                Text("Invalid Date")
                    .font(.headline)
                    .padding()
            }
        }
        .background(Color.clear)
    }
}

struct ForecastDayRow_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDayRow(dayForecast: Forecastday.mockData())
                    .environmentObject(HandleThem())
    }
}


extension Forecastday {
    static func mockData() -> Forecastday {
        let sampleCondition = Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000)

        let sampleDay = Day(maxtempC: 25.0, mintempC: 15.0, condition: sampleCondition)

        let sampleAstro = Astro(sunrise: "6:00 AM", sunset: "8:00 PM", moonrise: "7:00 PM", moonset: "5:00 AM", moonPhase: "Waxing Crescent", moonIllumination: 25, isMoonUp: 1, isSunUp: 1)
  
        let sampleHour = Hour(time: "2024-05-19 04:00", tempC: 9.2, isDay: 0, condition: sampleCondition, pressureMB: 1013.0, humidity: 96, feelslikeC: 8.5, visKM: 2.0)
  
        return Forecastday(date: "2024-05-19", dateEpoch: 1716087600, day: sampleDay, astro: sampleAstro, hour: [sampleHour])
    }
}
