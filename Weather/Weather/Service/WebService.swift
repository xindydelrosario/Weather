//
//  File.swift
//  Weather
//
//  
//


import Foundation
import CoreLocation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class WebService: NSObject {
    
    private let locationManager = CLLocationManager()
    private var dataTask: URLSessionDataTask?


    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastViewModel {
        
        guard let url = URL.getForecastByLocation(latitude: latitude, longitude: longitude)
        else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let forecast = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return ForecastViewModel(myWeather: weatherResponse(forecast: forecast))
    }
    

    func getForecastByCity(city: String, completion: @escaping (Result<weatherResponse?, NetworkError>) -> Void) {
        
        guard let url = URL.getForecastByCity(city)
        else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let forecast = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(weatherResponse(forecast: forecast)))
            
        }.resume()
    }
  }

////MARK: - HTTP REQUEST KUNIN YUNG DATA FROM URL PAPAPUNTANG APP
//final class NetworkManager<T: Codable> {
//static func fetchWeather(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
//URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//    //MARK: - DATA
//    guard let data = data else {
//        completion(.failure(.invalidData))
//        return
//    }
//    //MARK: - SERVER
//    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//        completion(.failure(.invalidResponse))
//        return
//    }
//    //MARK: - TRANSPO
//    guard error == nil else {
//        print(String(describing: error))
//        if let error = error?.localizedDescription {
//            completion(.failure(.error(err: error)))
//        }
//        return
//    }
//
//    //MARK: - URL DECODER
//    do {
//        let json = try JSONDecoder().decode(T.self, from: data)
//        completion(.success(json))
//    } catch let err {
//        print(String(describing: err))
//        completion(.failure(.decodingError(err: err.localizedDescription)))
//    }
//}.resume()
//}
//}
//
//enum NetworkError: Error {
//case invalidResponse
//case invalidData
//case decodingError(err: String)
//case error(err: String)
//}


