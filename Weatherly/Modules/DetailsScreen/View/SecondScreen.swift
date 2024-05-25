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
    var secondViewModel = SecondViewModel.shared
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
                        ForEach(secondViewModel.displayHours(for: day), id: \.time) { hour in
                            HStack {
                                let hourFormat = secondViewModel.convertTo12HourFormat(timeString: hour.time ?? "")
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
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen(selectedDay: Forecastday.mockData())
                   .environmentObject(HandleThem())
    }
}
