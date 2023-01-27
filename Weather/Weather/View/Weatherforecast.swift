//
//  ForecastListView.swift
//  myWeather
//
//  
//

import SwiftUI

struct Weatherforecast: View {
    
    let ForecastVM: ForecastViewModel
    @EnvironmentObject var store: Store
    @AppStorage("isDarkMode") private var isDark = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // MARK: - Title
                
                VStack(alignment: .center) {
                    Text(ForecastVM.cityName)
                        .font(.title)
                        .bold()
                    
                    Text(ForecastVM.dailyDates[0].formatAsString())
                        .font(.title2)
                    
                    HStack(alignment: .center){
                        Image(ForecastVM.getIconFor(icon: ForecastVM.dailyWeatherIcons[0]))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Text("\(ForecastVM.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }//hstack
                    
                    Text(ForecastVM.description.capitalized)
                        .font(.title3)
                    
                }//Vstack
                .padding()
                .foregroundColor(Color("TextColor"))
                
                // MARK: - Detail
                
                CustomStackView {
                    Label {
                        Text("Helpful Info")
                    }
                icon: {
//                        Image(systemName: "square.grid.2x2")
                    }
                    
                } contentView: {
                    HStack {
                        HStack {
                            VStack(alignment: .leading) {
                                DetailRow(logo: "sunrise.fill", name: "Sunrise",
                                          value: ForecastVM.sunrise.formatAsString3())
                                
                                DetailRow(logo: "wind", name: "Wind speed",
                                          value: "\(ForecastVM.currentWind)m/s")
                                
                                DetailRow(logo: "thermometer.sun.fill", name: "Max Temperature",
                                          value: ForecastVM.temp_Max)
                                
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                DetailRow(logo: "sunset.fill", name: "Sunset",
                                          value: ForecastVM.sunset.formatAsString3())
                                
                                DetailRow(logo: "humidity", name: "Humidity",
                                          value: "\(ForecastVM.currentHumidity)%")
                                
                                DetailRow(logo: "thermometer.sun", name: "Min Temperature",
                                          value: ForecastVM.temp_Min)
                            }
                        }
                    }
                    

                
                
            }// CONTENTVIEW
            
            
            // MARK: - 5-Day Forecast
            
            CustomStackView {
                Label {
                    Text("Daily Forecast")
                }
            icon: {
//                    Image(systemName: "calendar")
                }
                
            } contentView: {
                VStack(spacing: 10) {
                    DailyRow(day: ForecastVM.dailyDates[0].formatAsString1(),
                             temp: "\(ForecastVM.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                    )
                    Divider()
                    
                    DailyRow(day: ForecastVM.dailyDates[1].formatAsString1(),
                             temp: "\(ForecastVM.getTempByUnit(unit: store.selectedUnit)[1])°\(String(store.selectedUnit.displayText.prefix(1)))"
                    )
                    Divider()
                    
                    DailyRow(day: ForecastVM.dailyDates[2].formatAsString1(),
                             temp: "\(ForecastVM.getTempByUnit(unit: store.selectedUnit)[2])°\(String(store.selectedUnit.displayText.prefix(1)))"
                    )
                    
                    Divider()
                    
                    DailyRow(day: ForecastVM.dailyDates[3].formatAsString1(),
                             temp: "\(ForecastVM.getTempByUnit(unit: store.selectedUnit)[3])°\(String(store.selectedUnit.displayText.prefix(1)))"
                    )
                    
                    Divider()
                    
                    DailyRow(day: ForecastVM.dailyDates[4].formatAsString1(),
                             temp: "\(ForecastVM.getTempByUnit(unit: store.selectedUnit)[4])°\(String(store.selectedUnit.displayText.prefix(1)))"
                    )
                }//vstack
            }
        }//ScrollView
        .preferredColorScheme(isDark ? .dark : .light)
    }//VStack
}
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityScreen()
            .environment(\.colorScheme, .dark)
    }
}
