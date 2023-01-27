//
//  CustomCell.swift
//  Weather
//
//  Created by xindy.del.rosario on 1/10/23.
//

import SwiftUI

struct DetailCards: View {
    
    @EnvironmentObject var store: Store
    @State var myWeather: ForecastViewModel!
    let city: String
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    HStack {
                        TabView {
                            //Current Location Forecast
                            ForEach(store.currentW, id: \.cityName) { myWeather in
                            CurrentWeather(myWeather: myWeather)
                            }
                            
                            //Added Cities Forecast
                            ForEach(store.weatherList, id: \.cityName) { myWeather in
                            CurrentWeather(myWeather: myWeather)
                          }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                        .tabViewStyle(PageTabViewStyle())
                    }
                }
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
        
    }
}

struct CustomCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailCards(city: "")
    }
}
