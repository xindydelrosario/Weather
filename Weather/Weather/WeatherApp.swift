//
//  WeatherApp.swift
//  Weather
//
// 
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            AddCityScreen()
                .environmentObject(Store())
        }
    }
}
