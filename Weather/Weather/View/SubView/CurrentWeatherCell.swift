//
//  CurrentWeatherList.swift
//  myWeather
//
// 
//

import SwiftUI

struct CurrentWeatherCell: View {
    
    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                Text("Current Location")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                
                Text(myWeather.cityName)
                    .font(.system(size: 13))
                    .foregroundColor(Color("TextColor"))
                }
                Spacer()
                Text("\(myWeather.dailyDates[0].formatAsString2())")
                    .font(.system(size: 15))
                    .foregroundColor(Color("TextColor"))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("TextColor"))
                    
                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
                    .foregroundColor(Color("TextColor"))
            }
        }//Hstack
        .padding()
    }
}

struct CurrentWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        AddCityScreen()
    }
}

struct WeatherCell: View {

    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(myWeather.cityName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextColor"))

                    Text(" ")
                        .font(.system(size: 13))
                        .foregroundColor(Color("TextColor"))
                }
                Spacer()
                Text("\(myWeather.dailyDates[0].formatAsString2())")
                    .font(.system(size: 15))
                    .foregroundColor(Color("TextColor"))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)

                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
                    .foregroundColor(Color("TextColor"))
            }
        }//Hstack
        .padding()
    }
}
