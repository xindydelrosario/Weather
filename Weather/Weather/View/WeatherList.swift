//
//  WeatherList.swift
//  Weather
//
//  
//

import SwiftUI

struct WeatherList: View {
    
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    @AppStorage("isDarkMode") private var isDark = false
    @EnvironmentObject var store: Store
    @ObservedObject var networkManager = NetworkManager()
    @State var myWeather: ForecastViewModel!
    @State var isEditing = false
    @State private var showCancelButton: Bool = false
    @StateObject private var addCityVM = AddCityViewModel()
    @StateObject var locationManager = LocationManager()
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    // MARK: - Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search for a city",
                                  text: $addCityVM.city,
                                  onEditingChanged: { isEditing in self.showCancelButton = true },
                                  onCommit: {addCityVM.getCity { myWeather in store.addWeather(myWeather)}
                        })
                        .foregroundColor(.accentColor)
                        
                        Button(action: {
                            self.addCityVM.city = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(addCityVM.city == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.addCityVM.city = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                
                List {
                    // MARK: - Current Location
                    if networkManager.isConnected {
                        if let location = locationManager.location {
                            if let myWeather = myWeather {
                                NavigationLink(destination: DetailCards(city: myWeather.cityName)) {
                                    CurrentWeatherCell(myWeather: myWeather)
                                }
                            } else {
                                LoadingView()
                                    .task {
                                        do {
                                            myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                            
                                        //Save or Update stored data
                                            if store.currentW.isEmpty {
                                                store.addCurrent(myWeather)
                                            } else {
                                                store.updateCurrent(myWeather)
                                            }
                                        } catch {
                                            print("Error getting weather: \(error)")
                                        }
                                    }
                            }
                        } else {
                            LoadingView()
                                .onAppear(perform: locationManager.requestLocation)
                        }
                    } else {
                        ForEach(store.currentW, id: \.cityName) { myWeather in
                            NavigationLink(destination: DetailCards(city: myWeather.cityName )) {
                                CurrentWeatherCell(myWeather: myWeather)
                            }
                        }
                    }
                    
                    // MARK: - Added Cities
//                    if networkManager.isConnected {
//                        //Update Stored WeatherList
//                          store.updateWeather(myWeather)
//                    } else {
                        ForEach(store.weatherList, id: \.cityName) { myWeather in
                            NavigationLink(destination: DetailCards(city: myWeather.cityName)) {
                            WeatherCell(myWeather: myWeather)
                        }
                    }
                    .onDelete(perform: store.deleteWeather)
//                    }//end of if else
                }//ScrollView
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            }//Vstack
            
            // MARK: - NavigationBar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        //Edit: Delete
                        Button {
                            self.isEditing.toggle()
                        } label: {
                            Label {
                                Text(isEditing ? "Done" : "Edit")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        //Theme: Dark or LightMode
                        Button {
                            isDark.toggle()
                        } label: {
                            Label {
                                Text("Theme: ")
                            } icon: {
                                Image(systemName: isDark ? "moon" : "sun.max")
                            }
                        }
                        
                        Divider()
                        //Temperatue Unit
                        Picker(selection: $selectedUnit, label: Text("")) {
                            ForEach(TemperatureUnit.allCases, id: \.self) {
                                Text("\($0.displayText)" as String)
                            }
                        }
                        .pickerStyle(.automatic)//adapt menu style
                        
                        Divider()
                        //Report Issue
                        Button {
                            print("Report an Issue")
                        } label: {
                            Label {
                                Text("Report an Issue")
                            } icon: {
                                Image(systemName: "exclamationmark.bubble")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }//End of Menu
                    //Update value when user select a unit
                    .onChange(of: selectedUnit) { newValue in
                        store.selectedUnit = selectedUnit
                    }
                }
            }
            .navigationBarTitle("myWeather")
            .foregroundColor(Color.accentColor)
        }//NvigationView
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherList()
    }
}
