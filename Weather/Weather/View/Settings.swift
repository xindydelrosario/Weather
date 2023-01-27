//
//  Settings.swift
//  Weather
//
// 
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    @AppStorage("isDarkMode") private var isDark = false
    
    var body: some View {
        VStack {
            Text("Settings")
                .fontWeight(.bold)
                .font(.system(size: 40))
                .offset(x:0 , y:50)
                .foregroundColor(Color("TextColor"))
            
            //  TEMPERATURE
            Section(header: Text("Temperature")
                .foregroundColor(Color("TextColor"))
                .offset(x: -140, y: 0)){
                    Picker(selection: $selectedUnit, label: Text("Select temperature unit?")) {
                        ForEach(TemperatureUnit.allCases, id: \.self) {
                            Text("\($0.displayText)" as String)
                        }
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .offset(x:0 , y:65)
                .foregroundColor(.black)
            
            // BACKGROUND
            Section(header: Text("Background")
                .offset(x: -140, y: 0)
                .foregroundColor(Color("TextColor"))) {
                    Picker("Mode", selection: $isDark) {
                        Text("Light Mode")
                            .preferredColorScheme(.light)
                            .tag(false)
                        Text("Dark Mode")
                            .preferredColorScheme(.dark)
                            .tag(true)
                    }
                }.offset(x: 0, y: 80)
                .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }//:VSTACK
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
