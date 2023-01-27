import Foundation

struct WeatherResponse: Codable {
    let city: City
    let list: [DateList]
}

struct City: Codable {
    let name: String
    let sunrise: Date
    let sunset: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sunriseTimeInterval = try container.decode(Int32.self, forKey: .sunrise)
        let sunsetTimeInterval = try container.decode(Int32.self, forKey: .sunset)
        sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseTimeInterval))
        sunset = Date(timeIntervalSince1970: TimeInterval(sunsetTimeInterval))
        name = try container.decode(String.self, forKey: .name)
    }
}

struct DateList: Codable {
    let dt: Date
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dtTimeInterval = try container.decode(Int32.self, forKey: .dt)
        dt = Date(timeIntervalSince1970: TimeInterval(dtTimeInterval))
        main = try container.decode(Main.self, forKey: .main)
        weather = try container.decode([Weather].self, forKey: .weather)
        wind = try container.decode(Wind.self, forKey: .wind)
    }
}

struct Main: Codable {
    let temp: Double
    let max: Double
    let min: Double
    let hum: Double

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case max = "temp_max"
        case min = "temp_min"
        case hum = "humidity"
    }
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

struct weatherResponse: Codable {
    let city: String
    let sunrise: Date
    let sunset: Date
    let temp0: Double
    let temp_Max0: Double
    let temp_Min0: Double
    let id: Int
    let hum: Double
    let speed: Double
    let icon0: String
    let desc0: String
    let date0: Date

    let temp1: Double
    let temp_Max1: Double
    let temp_Min1: Double
    let icon1: String
    let desc1: String
    let date1: Date

    let temp2: Double
    let temp_Max2: Double
    let temp_Min2: Double
    let icon2: String
    let desc2: String
    let date2: Date

    let temp3: Double
    let temp_Max3: Double
    let temp_Min3: Double
    let icon3: String
    let desc3: String
    let date3: Date

    let temp4: Double
    let temp_Max4: Double
    let temp_Min4: Double
    let icon4: String
    let desc4: String
    let date4: Date

    init(forecast: WeatherResponse) {
        city = forecast.city.name
        sunrise = forecast.city.sunrise
        sunset = forecast.city.sunset
        temp0 = forecast.list[0].main.temp
        temp_Max0 = forecast.list[0].main.max
        temp_Min0 = forecast.list[0].main.min
        id = forecast.list[0].weather[0].id
        hum = forecast.list[0].main.hum
        speed = forecast.list[0].wind.speed
        icon0 = forecast.list[0].weather[0].icon
        desc0 = forecast.list[0].weather[0].description
        date0 = forecast.list[0].dt

        temp1 = forecast.list[8].main.temp
        temp_Max1 = forecast.list[8].main.max
        temp_Min1 = forecast.list[8].main.min
        icon1 = forecast.list[8].weather[0].icon
        desc1 = forecast.list[8].weather[0].description
        date1 = forecast.list[8].dt

        temp2 = forecast.list[16].main.temp
        temp_Max2 = forecast.list[16].main.max
        temp_Min2 = forecast.list[16].main.min
        icon2 = forecast.list[16].weather[0].icon
        desc2 = forecast.list[16].weather[0].description
        date2 = forecast.list[16].dt

        temp3 = forecast.list[24].main.temp
        temp_Max3 = forecast.list[24].main.max
        temp_Min3 = forecast.list[24].main.min
        icon3 = forecast.list[24].weather[0].icon
        desc3 = forecast.list[24].weather[0].description
        date3 = forecast.list[24].dt

        temp4 = forecast.list[32].main.temp
        temp_Max4 = forecast.list[32].main.max
        temp_Min4 = forecast.list[32].main.min
        icon4 = forecast.list[32].weather[0].icon
        desc4 = forecast.list[32].weather[0].description
        date4 = forecast.list[32].dt
    }
}
