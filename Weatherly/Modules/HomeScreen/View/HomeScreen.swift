//
//  HomeScreen.swift
//  Weatherly
//
//  Created by Aya Mostafa on 19/05/2024.
//

import SwiftUI
import _CoreLocationUI_SwiftUI
import Kingfisher

struct HomeScreen: View {
    
    @StateObject var homeViewModel = HomeViewModel(network: ApiService())
    @State private var selectedDay: Forecastday?
    var days : Forecastday?
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            ZStack{
                Image(homeViewModel.theme.isTime ? "light" : "dark")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                VStack{
                    if let weather = homeViewModel.getWeather() {
                        HomeHeader(homeViewModel: homeViewModel)
                        Text("3-DAY FORECAST")
                            .frame(width: 370, height:20, alignment: .leading)
                            .font(Font.custom("YourCustomFontName", size: 20))
                            .foregroundColor(homeViewModel.theme.isTime ? .black : .white)
                            .padding(.top, 5)
                        Divider()
                            .background(Color.black)
                        
                        LazyVStack {
                            ForEach(weather.forecast.forecastday ?? []) { forecastDay in
                                    ForecastDayRow(dayForecast: forecastDay)
                                        .padding(.vertical, 5)
                                        .background(Color.clear)
                                
                                Divider()
                                    .background(Color.black)
                                    .padding(.leading,50)
                                    .padding(.trailing,50)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listStyle(PlainListStyle())
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 30) {
                                if let current = weather.current {
                                    WeatherGridItem(title: "VISIBILITY", value: "\(String(format: "%.1f", current.visKM ?? 0.0)) Km")
                                    WeatherGridItem(title: "HUMIDITY", value: "\(String(format: "%.1f", current.humidity ?? 0.0)) %")
                                    WeatherGridItem(title: "FEELS LIKE", value: "\(String(format: "%.1f", current.feelslikeC ?? 0.0)) °C")
                                    WeatherGridItem(title: "PRESSURE", value: "\(String(format: "%.1f", current.pressureMB ?? 0.0)) mb")
                                }
                            }
                            .padding()
                        }
                    }else{
                        Text("unkown")
                    }
                   // Spacer()
                }
                
            }
        }
    }
}


struct WeatherGridItem : View {
    let title: String
    let value: String
    @EnvironmentObject var theme: HandleThem
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(theme.isTime ? .black : .white)
            Text(value)
                .frame(width: 100)
                .font(.system(size: 16))
                .foregroundColor(theme.isTime ? .secondary : .white)
                .fontWeight(.bold)
                .padding(.trailing,10)
        }
        .padding()
    }
}

struct WeatherGridItem : View {
    let title: String
    let value: String
    @EnvironmentObject var theme: HandleThem
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(theme.isTime ? .black : .white)
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(theme.isTime ? .black : .white)
                .padding(.trailing,10)
        }
        .padding()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(HandleThem())
    }
}
  
