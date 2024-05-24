//
//  HomeHeader.swift
//  Weatherly
//
//  Created by Aya Mostafa on 21/05/2024.
//

import SwiftUI
import Kingfisher
struct HomeHeader: View {
    var homeViewModel = HomeViewModel(network: ApiService())
    init( homeViewModel: HomeViewModel?) {
        self.homeViewModel = homeViewModel!
    }
    var body: some View {
        Text(homeViewModel.getWeather()?.location.region ?? "")
                    .fixedSize()
                    .frame(width: 50, height: 38, alignment: .top)
                    //.padding(.top,80)
                    .foregroundColor(homeViewModel.theme.isTime ? .black : .white)
                    .font(.system(size: 45))
                    .buttonStyle(.bordered)
        Text(String(Int(homeViewModel.weatherRespond?.current.tempC ?? 0))+"°")
                    .fixedSize()
                    .frame(width: 50, height: 28, alignment: .top)
                    //.padding(.top,-55)
                    .fontWeight(/*@START_MENU_TOKEN@*//*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*//*@START_MENU_TOKEN@*/)
                    .foregroundColor(homeViewModel.theme.isTime ? .black : .white)
                    .font(.system(size: 35))
                    .buttonStyle(.bordered)
                //image
                Text(homeViewModel.getWeather()?.current.condition?.text ?? "")
                    .fixedSize()
                    .frame(width: 50, height: 34, alignment: .top)
                    //.padding(.top,-55)
                    .foregroundColor(homeViewModel.theme.isTime ? .black : .white)
                    .font(.system(size: 35))
                    .buttonStyle(.bordered)
                HStack{
                    Text("H:"+String(Int(homeViewModel.getWeather()?.forecast.forecastday?[0].day?.maxtempC ?? 0))+"°")
                       .frame(width: 70, height: 35, alignment: .top)
                        .foregroundColor(homeViewModel.theme.isTime ? .black : .white)
                        .font(.system(size: 25))
                        .buttonStyle(.bordered)
                    Text("L:"+String(Int(homeViewModel.getWeather()?.forecast.forecastday?[0].day?.maxtempC ?? 0))+"°")
                        .fixedSize()
                        .frame(width: 70, height: 35, alignment: .top)
                        .foregroundColor(homeViewModel.theme.isTime ? .black : .white)
                        .font(.system(size: 25))
                        .buttonStyle(.bordered)
                }
        KFImage.url(URL(string: Constants.BASE_URL+(homeViewModel.getWeather()?.current.condition?.icon ?? "")))
            .resizable()
            .scaledToFit()
            .frame(width: 50 , height: 50)
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader(homeViewModel: nil)
    }
}
