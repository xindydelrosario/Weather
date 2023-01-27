//
//  DetailCards.swift
//  myWeather
//
// 
//

import SwiftUI

struct DetailCards: View {
    
    @EnvironmentObject var store: Store
    @State var myWeather: ForecastViewModel!
    let city: String
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    HStack {
                        TabView {
                            //Current Location Forecast
                            ForEach(store.currentW, id: \.cityName) { myWeather in
                            Weatherforecast(ForecastVM: myWeather)
                            }
                            
                            //Added Cities Forecast
                            ForEach(store.weatherList, id: \.cityName) { myWeather in
                            Weatherforecast(ForecastVM: myWeather)
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

struct DetailCards_Previews: PreviewProvider {
    static var previews: some View {
        DetailCards(city: "")
    }
}
